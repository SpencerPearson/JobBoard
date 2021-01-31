using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using JobBoard.Data.EF;
using Microsoft.AspNet.Identity;

namespace JobBoard.UI.MVC.Models
{
    public class UserDetailsController : Controller
    {
        private JobBoardEntities db = new JobBoardEntities();

        // GET: UserDetails
        public ActionResult Index()
        {
            return View(db.UserDetails.ToList());
        }

        // GET: UserDetails/Details/5
        public ActionResult Details(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            UserDetail userDetail = db.UserDetails.Find(id);
            if (userDetail == null)
            {
                return HttpNotFound();
            }

            

            return View(userDetail);
        }

        // GET: UserDetails/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: UserDetails/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "UserId,FirstName,LastName,ResumeFileName")] UserDetail userDetail)
        {
            if (ModelState.IsValid)
            {
                db.UserDetails.Add(userDetail);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(userDetail);
        }

        // GET: UserDetails/Edit/5
        public ActionResult Edit(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            UserDetail userDetail = db.UserDetails.Find(id);
            if (userDetail == null)
            {
                return HttpNotFound();
            }
            return View(userDetail);
        }

        // POST: UserDetails/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "UserId,FirstName,LastName,ResumeFileName")] UserDetail userDetail)
        {
            if (ModelState.IsValid)
            {
                db.Entry(userDetail).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(userDetail);
        }

        // GET: UserDetails/Delete/5
        public ActionResult Delete(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            UserDetail userDetail = db.UserDetails.Find(id);
            if (userDetail == null)
            {
                return HttpNotFound();
            }
            return View(userDetail);
        }

        // POST: UserDetails/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(string id)
        {
            UserDetail userDetail = db.UserDetails.Find(id);
            string path = Server.MapPath("~/Content/resumes/");
            string file = userDetail.ResumeFileName;
            if (file.ToLower() != "noresume.pdf")
            {
                FileInfo pdfFile = new FileInfo(path + file);
                if (pdfFile.Exists)
                {
                    pdfFile.Delete();
                }
            }
            userDetail.ResumeFileName = "NoResume.pdf";
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        // GET: MyResume
        public ActionResult MyResume()
        {
            string id = User.Identity.GetUserId();
            UserDetail detail = db.UserDetails.Where(u => u.UserId == id).Single();
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            UserDetail userDetail = db.UserDetails.Find(id);
            if (userDetail == null)
            {
                return HttpNotFound();
            }
            return View(userDetail);
        }
        // POST : MyResume
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult MyResume([Bind(Include = "UserId,FirstName,LastName,ResumeFileName")] UserDetail userDetail, HttpPostedFileBase resumeFile)
        {
            #region File Upload
            string file = "NoResume.pdf";

            if (resumeFile != null)
            {
                file = resumeFile.FileName;
                string ext = file.Substring(file.LastIndexOf('.'));
                //string[] goodExts = { ".pdf", ".doc", ".docx" };

                if (ext.ToLower() == ".pdf")
                {
                    if (resumeFile.ContentLength <= 4194304)
                    {
                        file = Guid.NewGuid() + ext;
                        resumeFile.SaveAs(Server.MapPath("~/Content/resumes/" + file));

                    }
                    userDetail.ResumeFileName = file;
                }
            }
            #endregion
            if (ModelState.IsValid)
            {
                db.Entry(userDetail).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("MyResume");
            }
            return View(userDetail);
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
