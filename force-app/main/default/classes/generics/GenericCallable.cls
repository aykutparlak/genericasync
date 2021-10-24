/***********************************************************************************************************************
Apex Class Name     : GenericCallable
Version             : 1.0
Created Date        : 30.03.2021
Function            : GenericCallable class
Modification Log    :
* Developer                 Date                    Description
* ----------------------------------------------------------------------------------------------------------------------
* Aykut Parlak             30/03/2021              Initial version
***********************************************************************************************************************/
public without sharing class GenericCallable implements Callable {
    public Object call(String action, Map<String, Object> args) {
        switch on action {
            when 'apexQueue' {
                Integer currentJobNumber = (Integer) args.get('currentJobNumber');
                Integer nextJobNumber = currentJobNumber + 1;
                List<AsyncJob> jobs = (List<AsyncJob>) args.get('jobs');
                AsyncJob job = jobs[currentJobNumber];
                System.debug('Current Running Job: ' + JSON.serialize(job));

                // here you can implement the new class/method
                try {
                    if (job.jobClass == 'System' && job.jobMethod == 'debug') {
                        System.debug(job);
                    } else {
                        throw new GenericCallableException('Method not implemented');
                    }
                    job.jobStatus = 'OK';
                } catch (Exception e) {
                    job.jobStatus = 'ERROR';
                    job.jobError = e.getMessage();
                }

                if (nextJobNumber < jobs.size()) {
                    GenericQueueable gq = new GenericQueueable(jobs, nextJobNumber);
                    System.enqueueJob(gq);
                }
            }
            when else {
                throw new GenericCallableException('Method not implemented');
            }
        }

        return null;
    }

    public class GenericCallableException extends Exception {
    }
}
