# Microsoft Azure Fundamentals

## Cloud Concepts

Services provided by cloud providers:

Basic
	1. Computer Power (You pay what you use, so it saves on costs)
	2. Storage (Request as much as you need)
	
### Shared responsability

Infrastructure as a service (IaaS), platform as a service (PaaS), and software as a service (SaaS). 
- IaaS places the most responsibility on the consumer, with the cloud provider being responsible for the basics of physical security, power, and connectivity.
- SaaS places most of the responsibility with the cloud provider. 
- PaaS, being a middle ground between IaaS and SaaS, rests somewhere in the middle and evenly distributes responsibility between the cloud provider and the consumer.
	
### Cloud models

1. Private
2. Public
3. Hybrid
	
### Benefits of cloud

- High availability (SLA: Service Level Agreement)
	- Not 100% because it needs time to backup, maintenance, etc.
	- In azure from 99% to 99.9% depending on the service
- Scalability: Increase or decrease and pay what you use

	- Horizontal: De/Increasing number of resources (Virtual Machines)
	- Vertical: De/Increasing capabilities of resources (CPU or RAM)
	
- Reliability: The ability to recover from failures

- Predictability: Predicts cost and performance depending on historical data

- Security: Allows to choose the security level, depending on IaaS, PaaS, SaaS.
	- Distributed denial of service (DDoS) attacks, making your network more robust and secure.

- Manageability 
	- Of the cloud: Resources
	- In the cloud: Like command interface or API
	
### Service Types

- IaaS: You’re essentially renting the hardware in a cloud datacenter

- PaaS: Is a middle ground between renting space in a datacenter and paying for a complete and deployed solution.

- SaaS: You’re essentially renting or using a fully developed application

	
--- 

## Architecture and services

### Services
- Azure Web Apps
- Azure functions (No coding)
- Azure Container Instances
- Relational DB

### Accounts 

Azure Account -> Subscriptions > Resource Group > Resources

* Resources can just be in one resource group

#### Sandbox
Many of the Learn exercises use a technology called the sandbox, which creates a temporary subscription that's added to your Azure account. This temporary subscription allows you to create Azure resources during a Learn module. Learn automatically cleans up the temporary resources for you after you've completed the module.

- Get-date
- az intercative
- az version
- az upgrade
- exit

### Azure physical infrastructure

Availability zones are physically separate datacenters within an Azure region.

Region pairs: Most Azure regions are paired with another region within the same geography (such as US, Europe, or Asia) at least 300 miles away. 

* What Azure feature replicates resources across regions that are at least 300 miles away from each other?
ANSWER: Region pairs

### Azure management infrastructure

Management Groups > Suscriptions > Resource Group > Resource


### Computer services and networking services

1. Virtual Machines: Virtual machine scale sets let you create and manage a group of identical, load-balanced VMs.
2. Azure Virtual Desktop: Is a desktop and application virtualization service that runs on the cloud.
3. Containers: Are a virtualization environment, and can contain multiple apps each one with it´s OS (There are PaaS)
	* Containers virtualize the OS (Includes the app with the necessary OS)
	* Virtual machines virtualize hardware (Includes the OS that include the app)
	* VM for Complete control, Containers for portability and performance
4. Azure Functions: Commonly used when you need to perform work in response to an event (often via a REST request), timer, or message from another Azure service
5. Azure App Service: Is a robust hosting option that you can use to host your apps in Azure (Web apps, API apps, WebJobs, Mobile apps)
6. Azure Virtual Networking: Enable Azure resources, such as VMs, web apps, and databases, to communicate with each other.


#### Serverless computing

1. No infrastructure management
2. Pay what you use
3. Scalability

##### Containers example

Containers are often used to create solutions by using a microservice architecture. This architecture is where you break solutions into smaller, independent pieces. For example, you might split a website into a container hosting your front end, another hosting your back end, and a third for storage. This split allows you to separate portions of your app into logical sections that can be maintained, scaled, or updated independently.

Imagine your website back-end has reached capacity but the front end and storage aren't being stressed. With containers, you could scale the back end separately to improve performance. If something necessitated such a change, you could also choose to change the storage service or modify the front end without impacting any of the other components.

####
--- 

## Management and governance




