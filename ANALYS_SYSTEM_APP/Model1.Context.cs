﻿//------------------------------------------------------------------------------
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
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class Database : DbContext
    {
        public Database()
            : base("name=Database")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<Change_History> Change_History { get; set; }
        public virtual DbSet<Data_Source> Data_Source { get; set; }
        public virtual DbSet<Document> Document { get; set; }
        public virtual DbSet<Document_Status> Document_Status { get; set; }
        public virtual DbSet<Document_Struct> Document_Struct { get; set; }
        public virtual DbSet<Document_Type> Document_Type { get; set; }
        public virtual DbSet<Load_History> Load_History { get; set; }
        public virtual DbSet<Login_History> Login_History { get; set; }
        public virtual DbSet<Registration_Request> Registration_Request { get; set; }
        public virtual DbSet<Report> Report { get; set; }
        public virtual DbSet<Report_Type> Report_Type { get; set; }
        public virtual DbSet<Request_Status> Request_Status { get; set; }
        public virtual DbSet<sysdiagrams> sysdiagrams { get; set; }
        public virtual DbSet<User> User { get; set; }
        public virtual DbSet<User_Role> User_Role { get; set; }
        public virtual DbSet<User_Status> User_Status { get; set; }
        public virtual DbSet<Organisation_News> Organisation_News { get; set; }
        public virtual DbSet<Request_Decline> Request_Decline { get; set; }
        public virtual DbSet<Login_Status> Login_Status { get; set; }
    }
}
