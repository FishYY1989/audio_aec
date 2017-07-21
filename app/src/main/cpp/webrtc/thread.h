#pragma once
#include <thread>

#ifdef _WIN32
#define REICHBASE_API __declspec( dllexport )
#include <Windows.h>
#define ATOMIC_ADD(p) InterlockedIncrement(&p)
#define ATOMIC_DEC(p) InterlockedDecrement(&p)
#define ATOMIC_GET(p) InterlockedExchangeAdd(&p,0)
#else
#define REICHBASE_API
#define ATOMIC_ADD(p) __sync_add_and_fetch(&p,1)
#define ATOMIC_DEC(p) __sync_sub_and_fetch(&p,1)
#define ATOMIC_GET(p) __sync_fetch_and_add(&p,0)
#endif

class Mutex;
class REICHBASE_API Thread
{
public:
	Thread(void* context);
	virtual ~Thread();

	enum ThreadPriority {
		PRIORITY_LOWEST = 1,
		PRIORITY_BELOW_NORMAL = 5,
		PRIORITY_NORMAL = 10,
		PRIORITY_ABOVE_NORMAL = 15,
		PRIORITY_HIGHEST = 20,
		PRIORITY_TIME_CRITICAL //only for windows
	};

public:
	virtual void	run() = 0;
	int	start();
	void stop();
	void setPriority(int priority);
	int getPriority();
	void deleteThread(); //only for system call!

public:
	static void	sleep(int millsecs);

private:
    std::thread* m_pThread;
	int m_nPriority;
};
