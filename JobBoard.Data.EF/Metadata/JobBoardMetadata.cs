using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JobBoard.Data.EF//Metadata
{
    #region Application Metadata
    public class ApplicationMetadata
    {
        
        [Required]
        [Display(Name = "Position")]
        public int OpenPositionId { get; set; }

        [Required]
        [Display(Name = "User ID")]
        public string UserId { get; set; }

        [Display(Name = "Application Date")]
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:dd/MM/yy}")]
        public System.DateTime ApplicationDate { get; set; }

        [Display(Name = "Manager Notes")]
        [UIHint("MultilineText")]
        public string ManagerNotes { get; set; }

        
        [Display(Name = "Application Status")]
        public int ApplicationStatus { get; set; }

        [Display(Name = "Resume")]
        public string ResumeFilename { get; set; }

        [MetadataType(typeof(ApplicationMetadata))]
        public partial class Application
        {

        }
        
    }
    #endregion

    #region ApplicationStatus Metadata
    public class ApplicationStatusMetadata
    {
        [Display(Name = "Status")]
        public string StatusName { get; set; }

        [Display(Name = "Description")]
        [UIHint("MultilineText")]
        public string StatusDescription { get; set; }
    }
    [MetadataType(typeof(ApplicationStatusMetadata))]
    public partial class ApplicationStatus
    {

    }

    #endregion

    #region AspNetUser Metadata

    public class AspNetUserMetadata
    {
        [Required]
        public string Email { get; set; }

        [Required]
        [Display(Name = "Phone Number")]
        [DataType(DataType.PhoneNumber)]
        public string PhoneNumber { get; set; }
        
    }
    [MetadataType(typeof(AspNetUserMetadata))]
    public partial class AspNetUser
    {

    }
    #endregion

    #region Location Metadata
    public class LocationMetadata
    {
        [Required]
        [Display(Name = "Store Number")]
        public string StoreNumber { get; set; }

        [Required]
        public string City { get; set; }

        [Required]
        [StringLength(2, ErrorMessage = "Please use the 2 character state abbreviation.")]
        public string State { get; set; }

        [Display(Name = "Manager ID")]
        public string ManagerId { get; set; }
    }

    [MetadataType(typeof(LocationMetadata))]
    public partial class Location
    {

    }
    #endregion

    #region OpenPosition Metadata

    public class OpenPositionMetadata
    {
        [Display(Name = "Position")]
        public int PositionId { get; set; }

        [Display(Name = "Location")]
        public int LocationId { get; set; }
    }
    [MetadataType(typeof(OpenPositionMetadata))]
    public partial class OpenPosition
    {

    }
    #endregion

    #region Position Metadata
    public class PositionMetadata
    {
        [Required]
        [Display(Name = "Job Title")]
        public string Title { get; set; }

        [Required]
        [Display(Name = "Job Description")]
        [UIHint("MultilineText")]
        public string JobDescription { get; set; }

        [MetadataType(typeof(PositionMetadata))]
        public partial class Position
        {

        }
    }
    #endregion

    #region UserDetail Metadata
    public class UserDetailMetadata
    {
        [Required]
        [Display(Name = "First Name")]
        public string FirstName { get; set; }

        [Required]
        [Display(Name = "Last Name")]
        public string LastName { get; set; }

        [Required]
        [Display(Name = "Resume")]
        public string ResumeFileName { get; set; }

    }

    [MetadataType(typeof(UserDetailMetadata))]
    public partial class UserDetail
    {

    }
    #endregion
}
