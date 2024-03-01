# Examination_System_ITI_Graduation_Project


- [Description](#description)
- [DataBase Design](#DataBase-Design)
    - [ERD](#ERD)
    - [Mapping Schema](#Mapping-Schema)
- [Data Warehouse](#Data-Warehouse)
    - [Snowflake Schema](#Snowflake-Schema)
    - [DWH Implementation](#DWH-Implementation)
- [Reports](#Reports)
- [Website](#Website)
- [Dashboards](#Dashboards)
- [Tools](#Tools)


## Description

- Project Overview:
This project focuses on developing a comprehensive database management system aimed at streamlining operations within the educational institution, specifically the Information Technology Institute (ITI). It comprises various components including entity relationship diagrams (ERD), mapping, database implementation, and the creation of stored procedures for all tables in the database. Additionally, it involves the development of stored procedures for exam management, data warehousing utilizing snowflake diagrams, and the implementation of the Data Warehouse (DWH) using SQL Server Integration Services (SSIS). Moreover, the project includes the establishment of reporting functionalities using SQL Server Reporting Services (SSRS), alongside the development of a user-friendly website and dashboards for improved data visualization and analysis.

- Business Case:
This project aims to address the need for a robust database system tailored to meet the specific requirements of educational institutions. By centralizing data management and providing extensive reporting capabilities, it seeks to enhance decision-making processes and overall operational efficiency.

- ERD and Mapping:
The entity relationship diagram (ERD) illustrates the database schema, highlighting the relationships between various entities such as students, instructors, courses, exams, and more. Mapping visualizes data relationships within the database structure, facilitating understanding and analysis.

- Stored Procedures:
Stored procedures are developed to streamline data manipulation and reporting functionalities. These include basic stored procedures (Insert, Select, Update, Delete) totaling 78, alongside specialized procedures for exam generation, exam answers, and exam correction.

- Data Warehouse:
This project incorporates data warehousing principles, including slowly changing dimensions (SCD) and column tracking techniques, to effectively manage changes to dimension attributes over time.

- Snowflake Diagram:
The snowflake diagram provides a hierarchical view of the database schema, showcasing the denormalization of data and relationships between tables.

- SSRS Reports:
SQL Server Reporting Services (SSRS) generates comprehensive reports, offering insights into various aspects of the educational institution's operations. A total of 6 reports are generated, covering information such as student details, grades, course topics, exam questions, and more.

- Website:
A user-friendly website is developed using ASP.NET Core 6 MVC, providing a platform for accessing and interacting with the database system using EF Core, and creating website views (UI) using HTML, CSS, and JS.
In this project, we created an online exam system where students can log in with their email and password provided by ITI, which are saved in the database. After logging in, the exam instructions page will appear with all details related to the exam. Then, the student will be redirected to the exam page with a timer set to 30 minutes and 10 questions. After submitting the exam, the student will be directed to the grade page with their full name, grade percentage, and exam status. If the student answers some questions and the exam time expires, the exam will be submitted automatically, and the student will be directed to the grade page with a grade based on their correct answers. If the student does not answer any questions and the exam time expires, the exam will be submitted automatically, and the student will be directed to the grade page with a grade of 0.0% and a status of failed.

- Dashboards:
Dashboards are created using Microsoft Power BI Desktop to visualize data trends and insights. With a total of 30 dashboards, including tooltips, drill-through capabilities, filters, and a dashboard for information sourced from students' Facebook accounts, users are empowered with actionable information for decision-making.


## DataBase Design

### ERD
![Demo Sample](https://github.com/Sandra-Essa/Examination_System_ITI_Graduation_Project/blob/main/Media/ERD.png)

### Mapping Schema
![Demo Sample](https://github.com/Sandra-Essa/Examination_System_ITI_Graduation_Project/blob/main/Media/MappingDB.png)


## Data Warehouse

### Snowflake Schema
![Demo Sample](https://github.com/Sandra-Essa/Examination_System_ITI_Graduation_Project/blob/main/Media/Snowflake.png)

### DWH Implementation

- In a data warehousing environment, effective data modeling is essential for structuring the database schema to efficiently store and analyze data. Dimension tables form the foundation of the data warehouse, providing descriptive attributes and context for measures stored in fact tables. These dimensions include entities such as students, student grades, branches, instructors, graduates, courses, tracks, exams, and questions. Each dimension table outlines specific attributes relevant to its entity, facilitating comprehensive data analysis.

- The fact table, on the other hand, captures transactional data pertaining to student activities within the educational institution. It records essential metrics and measures associated with student performance, progress, and interactions. Utilizing foreign keys referencing dimension tables, the fact table establishes relationships and provides context for recorded transactions. Notable transactional details include student ID, track ID, branch ID, exam ID, and transaction date, enabling thorough drill-down analysis. Additional attributes such as creation timestamp and source system code are included for auditing and data lineage purposes.

- Furthermore, Slowly Changing Dimensions (SCD) techniques are employed to manage changes to dimension attributes over time. These techniques ensure historical accuracy and facilitate tracking of changes in dimensional data. Each dimension table may exhibit varying SCD types, distinguishing columns as changing, historical, or fixed. This systematic approach enhances the efficiency and reliability of the data warehousing system, enabling comprehensive data management and analysis.


## Reports
![Demo Sample](https://github.com/Sandra-Essa/Examination_System_ITI_Graduation_Project/blob/main/Media/SSRS%20Paginated.gif)

## Website
![Demo Sample](https://github.com/Sandra-Essa/Examination_System_ITI_Graduation_Project/blob/main/Media/Exam.gif)

## Dashboards
![Demo Sample](https://github.com/Sandra-Essa/Examination_System_ITI_Graduation_Project/blob/main/Media/ITI_Examination_System.gif)

![Demo Sample](https://github.com/Sandra-Essa/Examination_System_ITI_Graduation_Project/blob/main/Media/Facebook.png)


## Tools

1. Utilize Draw.io, an online platform, for crafting Entity Relationship Diagrams (ERD) and Database schemas.
2. Employ SQL Server Management Studio for the execution of database implementations.
3. Leverage SQL Server Reporting Service and Visual Studio to implement comprehensive reports.
4. Utilize SQL Server Management Studio and SQL Server Integration Service for the establishment of Datawarehouses.
5. Utilize Microsoft Power BI Desktop for the creation of dynamic Dashboards.
6. Employ Microsoft Fabric (Power BI Service) and Microsoft Power BI Desktop for seamless integration with Paginated Reports generated by SSRS.
7. Utilize HTML, CSS, and JavaScript for the development of the website's Front-End.
8. Implement ASP.NET Core 6 along with Entity Framework Core version 6.0.2, Entity Framework Core.SqlServer Version 6.0.26, EntityFrameworkCore.Tools Version 6.0.26 packages, and EF Core Power Tools for the design of the website's Back-End.
