/***********************************************************************************************************************
Apex Class Name     : GenericQueueable
Version             : 1.0
Created Date        : 30.03.2021
Function            : GenericQueueable class
Modification Log    :
* Developer                 Date                    Description
* ----------------------------------------------------------------------------------------------------------------------
* Aykut Parlak             30/03/2021              Initial version
***********************************************************************************************************************/
public class GenericQueueable implements Queueable, Database.AllowsCallouts {
    private List<AsyncJob> jobs;
    private Integer currentJobNumber;

    public GenericQueueable(List<AsyncJob> jobs, Integer currentJobNumber) {
        this.jobs = jobs;
        this.currentJobNumber = currentJobNumber;
    }

    public GenericQueueable(List<AsyncJob> jobs) {
        this.jobs = jobs;
        this.currentJobNumber = 0;
    }

    public void execute(QueueableContext context) {
        GenericCallable gc = new GenericCallable();
        gc.call('apexQueue', new Map<String, Object>{ 'jobs' => this.jobs, 'currentJobNumber' => this.currentJobNumber });
    }
}