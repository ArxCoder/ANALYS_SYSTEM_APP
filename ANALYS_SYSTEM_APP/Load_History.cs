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
    
    public partial class Load_History
    {
        public int ID { get; set; }
        public string Source_File_Name { get; set; }
        public Nullable<System.DateTime> Date { get; set; }
        public Nullable<int> User_ID { get; set; }
        public Nullable<int> Document_ID { get; set; }
        public Nullable<int> Data_Source_ID { get; set; }
    
        public virtual Data_Source Data_Source { get; set; }
        public virtual Document Document { get; set; }
        public virtual User User { get; set; }
    }
}
