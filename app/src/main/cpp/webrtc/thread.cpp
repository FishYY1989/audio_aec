#include "thread.h"
#include "logsdk/logger.h"
//#include <thread>
#include <set>
#if !defined(_WIN32)
#include <pthread.h>
#endif

#include <errno.h>
#include <string.h>

#define STOP_TIMEOUT_MS 2000

static std::set<Thread*> k_signalThreadPool;

void timeoutSignalHandler(int arg)
{
	for ( std::set<Thread*>::const_iterator io = k_signalThreadPool.begin(); io != k_signalThreadPool.end(); ++io )
	{
		(*io)->deleteThread();
	}
	k_signalThreadPool.clear();
}

Thread::Thread(void* context)
: m_pThread(NULL)
, m_nPriority(PRIORITY_NORMAL)
{}

Thread::~Thread()
{
	stop();
}

int Thread::start()
{
	if (m_pThread)
	{
		FUNLOGE(" already started! thread_id:%d", m_pThread->get_id());
		return -1;
	}

    m_pThread = new std::thread(&Thread::run, this);

	FUNLOGI(" thread_id:%d", m_pThread->get_id());
	return 0;
}

void Thread::stop()
{
	if (m_pThread)
	{
//#define STOP_WITH_TIMEOUT

#if defined(STOP_WITH_TIMEOUT)
	#if defined(_WIN32)
		FUNLOGI("try to stop, wait sub thread finish, thread_id:%d", m_pThread->get_id());
		WaitForSingleObject(m_pThread->native_handle(), STOP_TIMEOUT_MS);
		FUNLOGI("real stop thread, thread_id:%d", m_pThread->get_id());
		m_pThread->detach(); //delete thread request it MUST join or detach first!
		delete m_pThread;
		m_pThread = NULL;
	#else
		FUNLOGI("try to stop, wait sub thread finish, thread_id:%d", m_pThread->get_id());
		k_signalThreadPool.insert(this);
		signal(SIGALRM, timeoutSignalHandler);
		alarm(STOP_TIMEOUT_MS/1000);
		if ( m_pThread->joinable() )
		{
			FUNLOGI(" join1 thread_id:%d", m_pThread->get_id());
			m_pThread->join();
			FUNLOGI(" join2 thread_id:%d", m_pThread->get_id());
		}
		k_signalThreadPool.erase(this);
		if ( k_signalThreadPool.empty() )
		{
			alarm(0);
		}
		if (m_pThread)
		{
			FUNLOGI("real stop thread, thread_id:%d", m_pThread->get_id());
			delete m_pThread;
			m_pThread = NULL;
		}
	#endif
#else
		if ( m_pThread->joinable() )
		{
			FUNLOGI(" join1 thread_id:%d", m_pThread->get_id());
			m_pThread->join();
			FUNLOGI(" join2 thread_id:%d", m_pThread->get_id());
		}
		delete m_pThread;
		m_pThread = NULL;
#endif
	}
}

void Thread::deleteThread()
{
	if (m_pThread)
	{
		FUNLOGI("real stop thread, thread_id:%d", m_pThread->get_id());
        m_pThread->detach(); //delete thread request it MUST join or detach first!
		delete m_pThread;
		m_pThread = NULL;
	}
}

void Thread::setPriority(int priority)
{
	m_nPriority = priority;
#if defined(WIN32) || defined(_WIN32)
	int winPriority = THREAD_PRIORITY_NORMAL;
	switch (priority)
	{
	case PRIORITY_LOWEST:
		winPriority = THREAD_PRIORITY_LOWEST;
		break;
	case PRIORITY_BELOW_NORMAL:
		winPriority = THREAD_PRIORITY_BELOW_NORMAL;
		break;
	case PRIORITY_NORMAL:
		winPriority = THREAD_PRIORITY_NORMAL;
		break;
	case PRIORITY_ABOVE_NORMAL:
		winPriority = THREAD_PRIORITY_ABOVE_NORMAL;
		break;
	case PRIORITY_HIGHEST:
		winPriority = THREAD_PRIORITY_HIGHEST;
		break;
	case PRIORITY_TIME_CRITICAL:
		winPriority = THREAD_PRIORITY_TIME_CRITICAL;
		break;
	}
	::SetThreadPriority(m_pThread->native_handle(), winPriority);
#else
	sched_param sch;
	int policy;
	pthread_getschedparam(m_pThread->native_handle(), &policy, &sch);
	sch.sched_priority = priority; //20 is highest
	if (pthread_setschedparam(m_pThread->native_handle(), SCHED_FIFO, &sch))
	{
		FUNLOGE("pthread_setschedparam fail with error:%s", strerror(errno));
	}
#endif

	FUNLOGI(" thread_id:%d priority=%d", m_pThread->get_id(), priority);
}

int Thread::getPriority() {
	return m_nPriority;
}

void Thread::sleep(int millsecs)
{
	std::this_thread::sleep_for(std::chrono::milliseconds(millsecs));
}
