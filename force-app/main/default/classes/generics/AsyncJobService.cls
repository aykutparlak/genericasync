/***********************************************************************************************************************
Apex Class Name     : AsyncJobService
Version             : 1.0
Created Date        : 30.03.2021
Function            : AsyncJob Service class
Modification Log    :
* Developer                 Date                    Description
* ----------------------------------------------------------------------------------------------------------------------
* Aykut Parlak             30/03/2021              Initial version
***********************************************************************************************************************/
public with sharing class AsyncJobService {
    public static AsyncJob[] jobs;

    public static void addJob(AsyncJob job) {
        if (jobs != null)
            jobs.add(job);
        else {
            jobs = new List<AsyncJob>();
            jobs.add(job);
        }
    }

    public static void addJob(String jobName, String jobClass, String jobMethod, List<Id> recordIds) {
        AsyncJob job = new AsyncJob(jobName, jobClass, jobMethod, recordIds);
        addJob(job);
    }

    public static void runJobInQueues() {
        if (jobs == null || jobs.isEmpty())
            return;
        if (Test.isRunningTest())
            jobs = new List<AsyncJob>{ jobs[0] };
        GenericQueueable gq = new GenericQueueable(jobs);
        System.enqueueJob(gq);
        jobs.clear();
    }
}
