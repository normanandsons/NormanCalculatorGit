using System;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System.Web;

namespace NormanCalculator.Controllers
{
    [Route("NormanCalculator")]
    public class NormanCalculatorController : ControllerBase
    {
        private readonly ILogger<NormanCalculatorController> _logger;

        public NormanCalculatorController(ILogger<NormanCalculatorController> logger)
        {
            _logger = logger;
        }

        [HttpGet]
        [Route("Add")]
        public async Task<ResponseObject> AddNumbers(string input1, string input2)
        {
            var responseObject = new ResponseObject();
            try
            {
                var number1 = double.Parse(input1);
                var number2 = double.Parse(input2);

                await Task.Run(() => responseObject.Result = (number1 + number2).ToString());
                _logger.LogInformation("[{0}]: {1} + {2} = {3}", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"), input1, input2, responseObject.Result );
            }
            catch (Exception exception)
            {
                await Task.Run(() => responseObject.Result = exception.Message);
                _logger.LogError("[{0}]: Invalid info sent through {1} and {2}", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"), input1, input2 );
            }
            return responseObject;
        }

        [HttpGet]
        [Route("Subtract")]
        public async Task<ResponseObject> SubtractNumbers(string input1, string input2)
        {
            var responseObject = new ResponseObject();
            try
            {
                var number1 = double.Parse(input1);
                var number2 = double.Parse(input2);

                await Task.Run(() => responseObject.Result = (number1 - number2).ToString());
                _logger.LogInformation("[{0}]: {1} - {2} = {3}", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"), input1, input2, responseObject.Result );
            }
            catch (Exception exception)
            {
                await Task.Run(() => responseObject.Result = exception.Message);
                _logger.LogError("[{0}]: Crap info sent through {1} and {2}", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"), input1, input2 );
            }
            return responseObject;
        }
    
    }
}
