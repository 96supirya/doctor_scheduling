# Welcome to Doctors scheduling system

# Description
A busy clinic currently faces challenges in managing doctor availabilities, resulting in manual processes that are error-prone and lead to overbooking. This has caused frustration among patients.

## Task

Create a RESTful API service to facilitate a simple scheduling system. The service should:
   
## Summary: 
This project aims to address challenges in managing doctor availabilities, 
which has led to manual and error-prone processes causing patient frustration.

The RESTful API system focuses on:

-Managing doctor availabilities.   
-Allowing patients to book and edit appointments.

## Routes
Here are the defined routes for Rails application:


**Doctors**
**Index**: GET /doctors - Retrieves a list of doctors.  
**Create**: POST /doctors - Creates a new doctor.   
**Show**: GET /doctors/:id - Retrieves details for a specific doctor. 


**Member Routes (specific to a doctor)**    
**Working Hours**: GET /doctors/:id/working_hours - Retrieves the working hours of a specific doctor.         
**Availability**: GET /doctors/:id/availability - Retrieves the availability of a specific doctor.   
**Book Slot**: POST /doctors/:id/book_slot - Books a slot with a specific doctor.           

**Appointments**
**Update**: PATCH /appointments/:id - Updates details of a specific appointment.  
**Destroy**: DELETE /appointments/:id - Deletes a specific appointment.

## Thought Process

My approach will involve creating models for doctors, appointments, and availabilities. I implemented logic to handle slot booking, editing, and deletion. Additionally, I'll ensure proper validations to prevent overbooking.

## Data Models

## Doctor

- Attributes:
    - `name` (string): Name of the doctor.
    - `specialty` (string): Specialty of the doctor.
    - `working_hours`(json): Working hours of the doctor.
- Associations:
    - `has_many :availabilities`
    - `has_many :appointments`

The Doctor data model represents a healthcare professional within the application. 
It contains attributes for storing the doctor's name, specialty, and working hours.
Additionally, it has associations to manage the doctor's availability and appointments.


## Appointment

- Attributes:
    - `patient_name` (string): Name of the patient.
    - `appointment_time` (datetime): Date and time of the appointment.
    - `doctor_id` (integer): Id of the doctor.

- Associations:
    - `belongs_to :doctor` This  belongs_to association with the Doctor model, indicating that an appointment is associated with a single doctor.

## Usage
 The Appointment model allows you to manage appointments within your application. 
 It stores information such as the patient's name, the scheduled appointment time, and the associated doctor.

**Example**
appointment = Appointment.new(
patient_name: "John Doe",
appointment_time: DateTime.new(2023, 10, 12, 14, 30), # Date and time
doctor_id: 1 # ID of the doctor
)

**Saving the appointment entry**
appointment.save



## Availability

- Attributes:
    - `start_time` (datetime): The date and time when the availability period starts.
    - `end_time` (datetime): The date and time when the availability period ends.
    - `doctor_id` (integer): The ID of the associated doctor.

## Usage
 This establishes a belongs_to association with the Doctor model,
 indicating that an availability entry is associated with a single doctor.

**Example**

**Creating a new availability entry**

availability = Availability.new(
start_time: DateTime.new(2023, 10, 12, 9, 0), # Start time
end_time: DateTime.new(2023, 10, 12, 17, 0), # End time
doctor_id: 1 # ID of the doctor
)

 **Saving the availability entry**  
availability.save

## CONTROLLER DISCRIPTION
    
 # Doctors Controller
  
The DoctorsController handles HTTP requests related to doctors within the application.
   
**Actions**
## index
**HTTP Method**: GET   
**Endpoint**: /doctors   
**Purpose:** Retrieves a list of all doctors.                                 
**Response:**
If successful, it returns a list of doctors.
If there is an error, it returns a failure response with an error message.

## show
**HTTP Method**: GET    
**Endpoint**: /doctors/:id       
**Purpose**: Retrieves details for a specific doctor based on the provided id.             
**Response:** If successful, it returns details of the requested doctor.    If the doctor does not exist, it returns a failure response.


## create
**HTTP Method:** POST     
**Endpoint:** /doctors    
**Purpose:** Creates a new doctor with the provided parameters.
**Parameters:**               
**name (string):** The name of the doctor.  
**specialty (string):** The specialty of the doctor.   
**working_hours (json):** The working hours of the doctor in JSON format.      
**Response**:If successful, it returns details of the newly created doctor.
If there is an error, it returns a failure response with an error message.


## working_hours
**HTTP Method:** GET  
**Endpoint:** /doctors/:id/working_hours    
**Purpose:** Retrieves the working hours of a specific doctor based on the provided id.   
**Response**:If successful, it returns the working hours of the doctor.
If the doctor does not exist, it returns a failure response.


## availability
**HTTP Method:** GET        
**Endpoint:** /doctors/:id/availability    
**Purpose:** Retrieves the availability slots of a specific doctor based on the provided id.          
**Response:** If successful, it returns a list of available slots.
If the doctor does not exist, it returns a failure response.
 
## book slot
**HTTP Method:** POST   
**Endpoint:** /doctors/:id/book_slot       
**Purpose:** Books an appointment slot with a specific doctor.  
**Parameters:**
**appointment_time (string):** The desired appointment time (e.g., "tomorrow at 3 PM"). 
**patient_name (string):** The name of the patient booking the appointment.          
**Response:** If successful, it returns a success message indicating the appointment was booked.
If there is an error, it returns an error message.


**Private Methods**     
**parse_human_readable_time**     
**Purpose:** Parses a human-readable time string (e.g., "tomorrow at 3 PM") into a valid datetime object.      
**set_doctor**   
**Purpose:** Sets the @doctor instance variable based on the provided id parameter. 
**doctor_params**     
**Purpose:** Specifies the permitted parameters for creating or updating a doctor. It allows name, specialty, and working_hours to be updated.




             


## Appointments Controller

The AppointmentsController is responsible for handling HTTP requests related to appointments within the application.

Actions

## update
**HTTP Method**: PUT    
**Endpoint**: /appointments/:id      
**Purpose**: This action updates an existing appointment based on the provided parameters. It requires the `id` of the appointment to be specified in the URL.   
**Parameters**:  
`patient_name` (string): The updated name of the patient.  
`appointment_time` (datetime): The updated date and time of the appointment.   
**Response**:
If the update is successful, it returns a success response with the updated appointment details.
If the update fails, it returns a failure response with error messages.

## destroy 

**HTTP Method**: DELETE   
**Endpoint**: /appointments/:id  
**Purpose**: This action deletes an appointment. It requires the `id` of the appointment to be specified in the URL.

**Response**:
If the deletion is successful, it returns a success response.
If an error occurs during deletion, it returns a failure response with the error message.

## Before Actions
**set_appointment**: This private method is called before the update and destroy actions. It retrieves the appointment based on the id provided in the URL.    
**Private Methods**   
set_appointment  
Purpose: Retrieves the appointment based on the id provided in the URL.

**appointment_params**
Purpose: Specifies the permitted parameters for updating an appointment. In this case, it allows the patient_name and appointment_time to be updated.


This section provides an overview of the AppointmentsController, 
detailing its actions, their purposes, the corresponding HTTP methods and endpoints,
as well as the expected parameters and responses. Additionally, 
it explains the before actions and private methods used within the controller for handling appointments.











## Serializer
**AppointmentSerializer**
The AppointmentSerializer is used to format the data of an appointment before sending it as a response. It provides the following attributes:

id: The unique identifier of the appointment.    
doctor_name: The name of the doctor associated with the appointment.      
patient_name: The name of the patient associated with the appointment.    
appointment_time: The date and time of the appointment.    

The doctor_name attribute is a custom attribute defined using a serializer method to fetch the doctor's name from the associated doctor.



## Migrations

# Doctor Model

**create_doctors.rb**

**Purpose**: This migration creates the doctors table, which will store information about healthcare professionals.


**Attributes**:
**name** (string): Name of the doctor.   
**specialty** (string): Specialty of the doctor.      
**created_at** (datetime): Timestamp when the record is created.   
**updated_at** (datetime): Timestamp when the record is last updated.  

# Availability Model

**create_availabilities.rb**

**Purpose**: This migration creates the availabilities table, used to manage the availability of doctors.

Attributes:  
**start_time** (datetime): The date and time when the availability period starts.        
**end_time** (datetime): The date and time when the availability period ends.        
**doctor_id** (integer): The ID of the associated doctor.              
**created_at** (datetime): Timestamp when the record is created.
**updated_at** (datetime): Timestamp when the record is last updated.    

**Associations:**
belongs_to :doctor: Establishes a relationship with the Doctor model.

# Appointment Model  
**create_appointments.rb**

**Purpose**: This migration creates the appointments table, which is used to schedule appointments.

**Attributes**:
**patient_name** (string): Name of the patient.
**appointment_time** (datetime): Date and time of the appointment.
**doctor_id** (integer): ID of the doctor associated with the appointment.
**created_at** (datetime): Timestamp when the record is created.
**updated_at** (datetime): Timestamp when the record is last updated.

Associations:
belongs_to :doctor: Establishes a relationship with the Doctor model.

This section of the README provides a detailed description of each migration,
explaining its purpose and listing the attributes it adds to the corresponding table. 
Developers can refer to this information to understand how the database schema is structured and how each migration contributes to the data model.

## Additional Notes

### Project Overview:

This project involves building a RESTful API system for managing doctor availabilities and patient appointments. 
It includes data models for doctors, appointments, and availabilities. Additionally, the project provides controllers and serializers to facilitate seamless interaction with the API.
         
**Key Components:**

**Data Models:**

**Doctor:** Handles doctor information including name, specialty, and working hours.

**Controllers:**

**Doctors Controller:** Handles HTTP requests related to doctors, including listing, creating, and retrieving details.
Appointments Controller: Manages appointment-related requests like updates and deletions.

**Serializers**:

**AppointmentSerializer:** Formats appointment data for response, including appointment ID, doctor name, patient name, and appointment time.

**Migrations:**

Creates database tables for doctors, availabilities, and appointments, along with their respective attributes.

**README Purpose:**


The README serves as a comprehensive guide to help developers understand the project's structure, objectives, and functionality. 
It provides essential information to facilitate seamless development and integration of the API system.