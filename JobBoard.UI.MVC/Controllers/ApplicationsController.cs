using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.Mvc;
using JobBoard.Data.EF;
using JobBoard.UI.MVC.Models;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;

namespace JobBoard.UI.MVC.Controllers
{
    public class ApplicationsController : Controller
    {
        private JobBoardEntities db = new JobBoardEntities();

        //User manager for search of applicant 
        private ApplicationUserManager _userManager;
        public ApplicationUserManager UserManager
        {
            get
            {
                return _userManager ?? HttpContext.GetOwinContext().GetUserManager<ApplicationUserManager>();
            }
            private set
            {
                _userManager = value;
            }
        }


        // GET: Applications
        [Authorize(Roles = "Applicant, Admin, Manager")]
        public ActionResult Index()
        {
            var applications = db.Applications.Include(a => a.ApplicationStatus1).Include(a => a.OpenPosition).Include(a => a.UserDetail);
            var userId = User.Identity.GetUserId();

            if (User.IsInRole("Manager"))
            {
                var managerApps = applications.Where(a => a.OpenPosition.Location.ManagerId == userId);
                return View(managerApps.ToList());
            }
            if (User.IsInRole("Applicant"))
            {
                var applicantApps = applications.Where(a => a.UserId == userId);
                return View(applicantApps.ToList());
            }
            return View(applications.ToList());
        }

        // GET: Applications/Details/5
        [Authorize(Roles = "Applicant, Admin, Manager")]
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            Application application = db.Applications.Find(id);
            if (application == null)
            {
                return HttpNotFound();
            }
            return View(application);
        }

        //*******COMMENTED OUT CREATE ACTIONS AS ALL APPLICATIONS ARE CREATED VIA OneClick ACTION IN OpenPositions CONTROLLER *********
        // GET: Applications/Create
        //public ActionResult Create()
        //{
        //    ViewBag.ApplicationStatus = new SelectList(db.ApplicationStatuses, "ApplicationStatusId", "StatusName");
        //    ViewBag.OpenPositionId = new SelectList(db.OpenPositions, "OpenPositionId", "OpenPositionId");
        //    ViewBag.UserId = new SelectList(db.UserDetails, "UserId", "FirstName");
        //    return View();
        //}

        //// POST: Applications/Create
        //// To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        //// more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        //[HttpPost]
        //[ValidateAntiForgeryToken]
        //public ActionResult Create([Bind(Include = "ApplicationId,OpenPositionId,UserId,ApplicationDate,ManagerNotes,ApplicationStatus,ResumeFilename")] Application application)
        //{
        //    if (ModelState.IsValid)
        //    {
        //        db.Applications.Add(application);
        //        db.SaveChanges();
        //        return RedirectToAction("Index");
        //    }

        //    ViewBag.ApplicationStatus = new SelectList(db.ApplicationStatuses, "ApplicationStatusId", "StatusName", application.ApplicationStatus);
        //    ViewBag.OpenPositionId = new SelectList(db.OpenPositions, "OpenPositionId", "OpenPositionId", application.OpenPositionId);
        //    ViewBag.UserId = new SelectList(db.UserDetails, "UserId", "FirstName", application.UserId);
        //    return View(application);
        //}

        // GET: Applications/Edit/5
        [Authorize(Roles = "Admin, Manager")]
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Application application = db.Applications.Find(id);
            if (application == null)
            {
                return HttpNotFound();
            }

            ViewBag.ApplicationStatus = new SelectList(db.ApplicationStatuses, "ApplicationStatusId", "StatusName", application.ApplicationStatus);
            ViewBag.OpenPositionId = new SelectList(db.OpenPositions, "OpenPositionId", "OpenPositionId", application.OpenPositionId);
            ViewBag.UserId = new SelectList(db.UserDetails, "UserId", "FirstName", application.UserId);


            return View(application);
        }

        // POST: Applications/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [Authorize(Roles = "Admin, Manager")]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "ApplicationId,OpenPositionId,UserId,ApplicationDate,ManagerNotes,ApplicationStatus,ResumeFilename")] Application application)
        {
            if (ModelState.IsValid)
            {
                if (Session["originalStatus"] != null)
                {
                    int oldStatus = (int)Session["originalStatus"];
                    if (oldStatus != application.ApplicationStatus)
                    {
                        if (application.ApplicationStatus == 2)
                        {
                            string message = $"Hello, {application.UserDetail.FullName}! This is an automatic notification that your application for the {application.OpenPosition.Position.Title} position at our {application.OpenPosition.Location.City} location has been recieved by our hiring manager, {application.OpenPosition.Location.UserDetail.FullName}. You will receive further notification once your application is reviewed. Please allow 3-5 business days for your application to be reviewed. Please do not reply to this email, as the inbox is not monitored. If you have questions please fill out our contact form at http://jobboard.spencerpearson.net/Home/Contact \n\nThank you for your interest in Rocket Fuel Jobs!";

                            string subject = $"Status update on your {application.OpenPosition.Position.Title} application dated {application.ApplicationDate}";

                            ApplicationUser applicant = UserManager.FindById(application.UserId);

                            MailMessage mm = new MailMessage("no-reply@spencerpearson.net", applicant.Email, subject, message);

                            mm.ReplyToList.Clear();

                            SmtpClient client = new SmtpClient("mail.spencerpearson.net");
                            client.Credentials = new NetworkCredential("no-reply@spencerpearson.net", "aEaPa9uuEcOe$");

                            try
                            {
                                client.Send(mm);
                            }
                            catch (Exception ex)
                            {
                                ViewBag.ErrorMessage = "Your request could not be sent, please try again later.";

                            }

                        }
                        if (application.ApplicationStatus1.ApplicationStatusId == 3)
                        {
                            string message = $"Congratulations, {application.UserDetail.FullName}! This is an automatic notification that your application for the {application.OpenPosition.Position.Title} position at our {application.OpenPosition.Location.City} location has been accepted by our hiring manager, {application.OpenPosition.Location.UserDetail.FullName}. You will receive further instruction shortly regarding the next step in the interview process. \n\nThank you for your interest in Rocket Fuel Jobs!";

                            string subject = $"Status update on your {application.OpenPosition.Position.Title} application dated {application.ApplicationDate}";

                            ApplicationUser applicant = UserManager.FindById(application.UserId);

                            MailMessage mm = new MailMessage("no-reply@spencerpearson.net", applicant.Email, subject, message);

                            mm.ReplyToList.Clear();

                            SmtpClient client = new SmtpClient("mail.spencerpearson.net");
                            client.Credentials = new NetworkCredential("no-reply@spencerpearson.net", "aEaPa9uuEcOe$");

                            try
                            {
                                client.Send(mm);
                            }
                            catch (Exception ex)
                            {
                                ViewBag.ErrorMessage = "Your request could not be sent, please try again later.";

                            }
                        }
                        if (application.ApplicationStatus1.ApplicationStatusId == 4)
                        {
                            string message = $"Greetings, {application.UserDetail.FullName}. We are sorry to inform you that your application for the {application.OpenPosition.Position.Title} position at our {application.OpenPosition.Location.City} location has been rejected by our hiring manager, {application.OpenPosition.Location.UserDetail.FullName}. Although your application may not have matched what we are looking for currently, we encourage you to apply for other open positions you feel you may be qualified for. All applications are kept on file for six months, so you also may reapply for this position after {application.ApplicationDate.AddMonths(6):MM/dd/yyyy} if it is still open at that time. \n\nThank you for your interest in Rocket Fuel Jobs!";

                            string subject = $"Status update on your {application.OpenPosition.Position.Title} application dated {application.ApplicationDate}";

                            ApplicationUser applicant = UserManager.FindById(application.UserId);

                            MailMessage mm = new MailMessage("no-reply@spencerpearson.net", applicant.Email, subject, message);

                            mm.ReplyToList.Clear();

                            SmtpClient client = new SmtpClient("mail.spencerpearson.net");
                            client.Credentials = new NetworkCredential("no-reply@spencerpearson.net", "aEaPa9uuEcOe$");

                            try
                            {
                                client.Send(mm);
                            }
                            catch (Exception ex)
                            {
                                ViewBag.ErrorMessage = "Your request could not be sent, please try again later.";

                            }
                        }
                    }
                }
                //}

                db.Entry(application).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.ApplicationStatus = new SelectList(db.ApplicationStatuses, "ApplicationStatusId", "StatusName", application.ApplicationStatus);
            ViewBag.OpenPositionId = new SelectList(db.OpenPositions, "OpenPositionId", "OpenPositionId", application.OpenPositionId);
            ViewBag.UserId = new SelectList(db.UserDetails, "UserId", "FirstName", application.UserId);
            return View(application);
        }

        // GET: Applications/Delete/5
        [Authorize(Roles = "Admin, Manager")]
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Application application = db.Applications.Find(id);
            if (application == null)
            {
                return HttpNotFound();
            }
            DateTime deletionDate = application.ApplicationDate.AddMonths(6);
            if (DateTime.Now < deletionDate)
            {
                ViewBag.Message = $"Once reviewed, applications must be kept on record for 6 months after the date of completion.\nThis application cannot be deleted until {deletionDate:MM/dd/yyyy}";
            }
            return View(application);
        }

        // POST: Applications/Delete/5
        [HttpPost, ActionName("Delete")]
        [Authorize(Roles = "Admin, Manager")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Application application = db.Applications.Find(id);
            db.Applications.Remove(application);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
