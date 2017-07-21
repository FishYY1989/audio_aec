#include "webrtc/testfilewriter.h"
//#include "webrtc/logger.h"

//#define ENABLE_TEST_FILE

TestFileWriter::TestFileWriter(std::string filename)
    :m_pFile(NULL)
{
#ifdef ENABLE_TEST_FILE
  //  FUNLOGW("create test file:%s", filename.c_str());
    m_filename = filename;
    m_pFile = fopen(filename.c_str(), "wb+");
    if (m_pFile == NULL){
      //  FUNLOGE("file create failed. name = %s", filename.c_str());
    }
#endif
}

TestFileWriter::~TestFileWriter()
{
    closeFile();
}

int TestFileWriter::write(const char* data, int len)
{
    if (m_pFile) {
        return fwrite(data, 1, len, m_pFile);
    }
	return 0;
}

void TestFileWriter::closeFile()
{
    if (m_pFile){
        fclose(m_pFile);
        m_pFile = NULL;
    }
}

int TestFileWriter::removeFile()
{
    if (m_pFile) {
        closeFile();
        return remove(m_filename.c_str());
    }
    return -1;
}

