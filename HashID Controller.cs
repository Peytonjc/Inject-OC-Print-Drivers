using System;

using System.Collections.Generic;

using System.Linq;

using System.Net;

using System.Net.Http;

using System.Text;

using System.Web.Http;



namespace TestAPI.Areas.HelpPage.Controllers

{

    public class PrinterAPiController : ApiController

    {

        // GET: api/PrinterAPi

        public IEnumerable<string> Get()

        {

            return new string[] { "value1", "value2" };

        }



        // GET: api/PrinterAPi/5

        public string Get(int id)

        {

            return "value";

        }



        // POST: api/PrinterAPi

        public HttpResponseMessage Post(string username)

        {

            //Console.Write(request.studentName);

            HttpClient client = new HttpClient();



            HttpRequestMessage requestMessage = new HttpRequestMessage(HttpMethod.Get, "https://studentprinters.oc.edu/api/rest.cfm/useridhash/?username=" + username);

            requestMessage.Headers.Add("X-EOP-AuthToken", "Everyone print api");

            //string jsonAsStringContent = "{}";

            //requestMessage.Content = new StringContent(jsonAsStringContent, Encoding.UTF8, "application/json");

            HttpResponseMessage response = client.SendAsync(requestMessage).GetAwaiter().GetResult();

            //return client.SendAsync(requestMessage).GetAwaiter().GetResult();



            return response;

        }

        // PUT: api/PrinterAPi/5

        public void Put(int id, [FromBody] string value)

        {

        }
        // DELETE: api/PrinterAPi/5

        public void Delete(int id)

        {

        }

    }



}
