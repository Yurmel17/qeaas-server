#pragma once

//#include <drogon/HttpSimpleController.h>
#include <drogon/HttpController.h>

using namespace drogon;

class QuantumRandomNumberController : public drogon::HttpController<QuantumRandomNumberController>
{
  public:
    METHOD_LIST_BEGIN
    // Generate random number
    ADD_METHOD_TO(QuantumRandomNumberController::generateRandomNumber, "/random_number/{num_bytes}", Get);
    METHOD_LIST_END

    // Generate random number handler
    void generateRandomNumber(const HttpRequestPtr &req, std::function<void(const HttpResponsePtr &)> &&callback, int num_bytes);
};