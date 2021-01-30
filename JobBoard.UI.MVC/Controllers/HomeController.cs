using JobBoard.UI.MVC.Models;
using System.Net.Mail;
using System.Web.Mvc;
using System.Net;
using System;

namespace JobBoard.UI.MVC.Controllers
{
    public class HomeController : Controller
    {
        [HttpGet]
        public ActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public ActionResult About()
        {

            return View();
        }

        // GET: Contact
        [HttpGet]
        public ActionResult Contact()
        {
            return View();
        }
        // POST: Contact
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Contact(ContactViewModel cvm)
        {
            if (ModelState.IsValid)
            {
                string message = $"You have received an email from {cvm.FirstName} {cvm.LastName} with the subject of {cvm.Subject}. Please respond to {cvm.Email} with your response to the following message:\n\n{cvm.Message}";

                MailMessage mm = new MailMessage("no-reply@spencerpearson.net", "spencer.pearson.816@gmail.com", cvm.Subject, message);

                mm.IsBodyHtml = true;
                mm.ReplyToList.Add(cvm.Email);

                SmtpClient client = new SmtpClient("mail.spencerpearson.net");

                client.Credentials = new NetworkCredential("no-reply@spencerpearson.net", "aEaPa9uuEcOe$");

                try
                {
                    client.Send(mm);
                }
                catch (Exception ex)
                {
                    ViewBag.ErrorMessage = "Your request could not be sent, please try again later.";
                    return View(cvm);
                }

                return View("EmailConfirmation", cvm);
            }
            else
            {
                return View(cvm);
            }
        }
    }
}
