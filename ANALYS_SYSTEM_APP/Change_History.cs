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
    
    public partial class Change_History
    {
        public int ID { get; set; }
        public Nullable<System.DateTime> Change_Date { get; set; }
        public string Old_Value { get; set; }
        public string New_Value { get; set; }
        public string Reason { get; set; }
        public Nullable<int> User_ID { get; set; }
        public Nullable<int> Document_ID { get; set; }
    
        public virtual Document Document { get; set; }
        public virtual User User { get; set; }
    }
}
