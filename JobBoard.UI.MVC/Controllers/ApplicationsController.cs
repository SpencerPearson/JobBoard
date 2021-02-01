using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using JobBoard.Data.EF;
using Microsoft.AspNet.Identity;

namespace JobBoard.UI.MVC.Controllers
{
    public class ApplicationsController : Controller
    {
        private JobBoardEntities db = new JobBoardEntities();

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
            if (DateTime.Now < deletionDate )
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
