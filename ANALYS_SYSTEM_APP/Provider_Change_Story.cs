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
    
    public partial class Provider_Change_Story
    {
        public int ID { get; set; }
        public Nullable<int> User_ID { get; set; }
        public Nullable<int> Provider_ID { get; set; }
        public Nullable<System.DateTime> Date { get; set; }
    
        public virtual Provider Provider { get; set; }
        public virtual User User { get; set; }
    }
}
