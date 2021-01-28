using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;//Metadata

namespace JobBoard.UI.MVC.Models
{
    public class ContactViewModel
    {

        [Required(ErrorMessage = "*First Name Required")]
        [Display(Name = "First Name")]
        public string FirstName { get; set; }

        [Required(ErrorMessage = "*Last Name Required")]
        [Display(Name = "Last Name")]
        public string LastName { get; set; }

        [Required(ErrorMessage = "*Valid email address required")]
        [DataType(DataType.EmailAddress)]
        public string Email { get; set; }

        [Required(ErrorMessage ="* Please include a subject")]
        public string Subject { get; set; }

        [Required(ErrorMessage = "*Message cannot be empty")]
        [UIHint("MultilineText")]
        public string Message { get; set; }
    }
}