//------------------------------------------------------------------------------
// <auto-generated>
//     Этот код создан по шаблону.
//
//     Изменения, вносимые в этот файл вручную, могут привести к непредвиденной работе приложения.
//     Изменения, вносимые в этот файл вручную, будут перезаписаны при повторном создании кода.
// </auto-generated>
//------------------------------------------------------------------------------

namespace ANALYS_SYSTEM_APP
{
    using System;
    using System.Collections.Generic;
    
    public partial class Request_Decline
    {
        public int ID { get; set; }
        public Nullable<int> Registration_Request_ID { get; set; }
        public string Decline_Reason { get; set; }
        public Nullable<int> User_ID { get; set; }
    
        public virtual Registration_Request Registration_Request { get; set; }
        public virtual User User { get; set; }
    }
}
