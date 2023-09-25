#include "EnvironmentVariables.hpp"

using namespace RiverDreams::Environment;

std::string EnvironmentVariables::GetVariable(std::string variable)
{
    const char* value = std::getenv(variable.c_str());
    return value ? value : "";
}

std::string EnvironmentVariables::GetPWD()
{
    std::string pwd = GetVariable("PWD");
    return pwd == "" ? "/" : pwd;
}

std::string EnvironmentVariables::GetVirtualEnv()
{
    return GetVariable("VIRTUAL_ENV");
}
