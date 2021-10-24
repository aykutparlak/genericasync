# How to Use GenericAsync Queueable Method
- Create a static method
- Register the method in GenericCallable class
  - For example: 
    ``` java 
    if (job.jobClass == 'System' && job.jobMethod == 'debug') {
        System.debug(job); 
    }
    ```
- Add the job in the generic queue 
  ``` java  
  AsyncJobService.addJob(jobName, className, methodName, parameters);
  ```
- Run the queues
  ``` java
  AsyncJobService.runJobInQueues();
  ```