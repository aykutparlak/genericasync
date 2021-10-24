/***********************************************************************************************************************
Apex Class Name     : AsyncJob
Version             : 1.0
Created Date        : 30.03.2021
Function            : AsyncJob object definition
Modification Log    :
* Developer                 Date                    Description
* ----------------------------------------------------------------------------------------------------------------------
* Aykut Parlak             30/03/2021              Initial version
***********************************************************************************************************************/
public without sharing class AsyncJob {
    public String jobName;
    public String jobClass;
    public String jobMethod;
    public String jobStatus;
    public String jobError;
    public List<Id> recordIds;

    public AsyncJob(String jobName, String jobClass, String jobMethod, List<Id> recordIds) {
        this.jobName = jobName;
        this.jobClass = jobClass;
        this.jobMethod = jobMethod;
        this.recordIds = recordIds;
    }
}
