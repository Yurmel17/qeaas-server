#include "QuantumRandomNumberController.h"
#include <fstream>
#include <vector>
//#include <random>
#include <json/json.h>

void QuantumRandomNumberController::generateRandomNumber(const HttpRequestPtr &req, std::function<void(const HttpResponsePtr &)> &&callback, int num_bytes)
{
    Json::Value result;
    if (num_bytes <= 0 || num_bytes > 8) {
        result["return"] = 1;
        result["error_message"] = "Invalid num_bytes. Allowed range: 1 to 8.";
    }
    else {
        std::vector<char> buffer(num_bytes);
        std::ifstream urandom("/dev/urandom", std::ios::in | std::ios::binary);
        if (urandom)
        {
            urandom.read(buffer.data(), num_bytes);
            if (urandom)
            {
                uint64_t random_number = 0;
                std::memcpy(&random_number, buffer.data(), num_bytes);
                result["return"] = 0;
                result["random_number"] = Json::Value::UInt64(random_number);
            }
            else
            {
                result["return"] = 1;
                result["error_message"] = "Failed to read sufficient bytes from /dev/urandom.";
            }
            urandom.close();
        }
        else
        {
            result["return"] = 1;
            result["error_message"] = "Could not open /dev/urandom.";
        }
    }
    LOG_DEBUG << "generateRandomNumber handler called";

    auto resp = HttpResponse::newHttpJsonResponse(result);
    callback(resp);
}