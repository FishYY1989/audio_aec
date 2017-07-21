#ifndef FILEWRITEHELPER_H
#define FILEWRITEHELPER_H

#include <stdio.h>
#include <string>
#include "thread.h"

//NOTE:this class is not thread-safe
class REICHBASE_API TestFileWriter
{
public:
    TestFileWriter(std::string filename);
    ~TestFileWriter();

    int write(const char* data, int len);
    void closeFile();
    int removeFile();
private:
    FILE* m_pFile;
    std::string m_filename;
};

#endif // FILEWRITEHELPER_H
