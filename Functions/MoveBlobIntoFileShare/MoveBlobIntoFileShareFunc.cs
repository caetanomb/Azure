using System;
using System.IO;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Host;
using Microsoft.Extensions.Logging;

namespace MoveBlobIntoFileShare
{
    public class MoveBlobIntoFileShareFunc
    {
        // [FunctionName("MoveBlobIntoFileShareFunc")]
        // public void Run([BlobTrigger("samples-workitems/{name}", Connection = "")]Stream myBlob, string name, ILogger log)
        // {
        //     log.LogInformation($"C# Blob trigger function Processed blob\n Name:{name} \n Size: {myBlob.Length} Bytes");
        // }

        [FunctionName("MoveBlobIntoFileShareFunc")]
        public void Run([BlobTrigger("%InputBlobContainer%", Connection = "SourceBlobsConnection")]Stream myBlob, string name, ILogger log)
        {
            var blobPath = Environment.GetEnvironmentVariable("InputBlobContainer");
            log.LogInformation($"C# Blob trigger function Processed blob\n Name:{name} \n Size: {myBlob.Length} Bytes");
            log.LogInformation($"Blob path: {blobPath}");
        }       
    }
}
