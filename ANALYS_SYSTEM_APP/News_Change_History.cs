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
    
    public partial class News_Change_History
    {
        public int ID { get; set; }
        public Nullable<int> User_ID { get; set; }
        public Nullable<int> News_ID { get; set; }
        public string Old_Value { get; set; }
        public string New_Value { get; set; }
        public Nullable<System.DateTime> Date { get; set; }
    
        public virtual Organisation_News Organisation_News { get; set; }
        public virtual User User { get; set; }
    }
}
