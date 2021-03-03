using Newtonsoft.Json;

namespace NormanCalculator.Controllers
{
    public class ResponseObject
    {
        [JsonProperty("result")]
        public string Result { get; set; }
    }
}
