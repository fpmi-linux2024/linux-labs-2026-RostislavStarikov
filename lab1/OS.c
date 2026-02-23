#include <stdio.h>
#include <string.h>

#ifdef _WIN32
    #include <windows.h>
#endif

#ifdef linux
    #include <sys/utsname.h>
#endif

#ifdef APPLE
    #include <sys/utsname.h>
#endif

int main() {

#ifdef _WIN32
    printf("Operating System: Windows\n");

    // Get Windows version
    OSVERSIONINFOEX osvi;
    ZeroMemory(&osvi, sizeof(OSVERSIONINFOEX));
    osvi.dwOSVersionInfoSize = sizeof(OSVERSIONINFOEX);

    #pragma warning(push)
    #pragma warning(disable:4996) 
    if (GetVersionEx((OSVERSIONINFO*)&osvi)) {
        printf("Version: %d.%d (build %d)\n",
               (int)osvi.dwMajorVersion,
               (int)osvi.dwMinorVersion,
               (int)osvi.dwBuildNumber);

        if (osvi.dwMajorVersion == 10) {
            if (osvi.dwBuildNumber >= 22000)
                printf("Name: Windows 11\n");
            else
                printf("Name: Windows 10\n");
        }
        else if (osvi.dwMajorVersion == 6 && osvi.dwMinorVersion == 3)
            printf("Name: Windows 8.1\n");
        else if (osvi.dwMajorVersion == 6 && osvi.dwMinorVersion == 2)
            printf("Name: Windows 8\n");
        else if (osvi.dwMajorVersion == 6 && osvi.dwMinorVersion == 1)
            printf("Name: Windows 7\n");
        else if (osvi.dwMajorVersion == 6 && osvi.dwMinorVersion == 0)
            printf("Name: Windows Vista\n");
        else if (osvi.dwMajorVersion == 5 && osvi.dwMinorVersion == 1)
            printf("Name: Windows XP\n");
        else
            printf("Name: Other Windows version\n");
    }
    #pragma warning(pop)

    SYSTEM_INFO sysInfo;
    GetSystemInfo(&sysInfo);
    printf("Number of processors: %d\n", sysInfo.dwNumberOfProcessors);

    BOOL is64Bit = FALSE;
    #if defined(_WIN64)
        is64Bit = TRUE;
    #elif defined(_WIN32)
        BOOL (WINAPI *pIsWow64Process)(HANDLE, PBOOL) = NULL;
        HMODULE hKernel32 = GetModuleHandle("kernel32.dll");
        if (hKernel32) {
            pIsWow64Process = (BOOL (WINAPI*)(HANDLE, PBOOL))
                              GetProcAddress(hKernel32, "IsWow64Process");
            if (pIsWow64Process) {
                pIsWow64Process(GetCurrentProcess(), &is64Bit);
            }
        }
    #endif
    printf("OS Architecture: %s\n", is64Bit ? "64-bit" : "32-bit");

#elif linux
    printf("Operating System: Linux\n");

    struct utsname kernelInfo;
    if (uname(&kernelInfo) == 0) {
        printf("Kernel: %s %s\n", kernelInfo.sysname, kernelInfo.release);
        printf("Kernel version: %s\n", kernelInfo.version);
        printf("Architecture: %s\n", kernelInfo.machine);
        printf("Hostname: %s\n", kernelInfo.nodename);
    }

    FILE *fp = fopen("/etc/os-release", "r");
    if (fp) {
        char line[256];
        while (fgets(line, sizeof(line), fp)) {
            if (strncmp(line, "PRETTY_NAME=", 12) == 0) {
                char *start = strchr(line, '"');
                char *end = strrchr(line, '"');
                if (start && end && start < end) {
                    *end = '\0';
                    printf("Distribution: %s\n", start + 1);
                }
                break;
            }
        }
        fclose(fp);
    } else {
        fp = fopen("/etc/issue", "r");
        if (fp) {
            char issue[256];
            if (fgets(issue, sizeof(issue), fp)) {
                printf("Distribution: %s", issue);
            }
            fclose(fp);
        }
    }

    fp = fopen("/proc/cpuinfo", "r");
    if (fp) {
        char line[256];
        int cpuCount = 0;
        while (fgets(line, sizeof(line), fp)) {
            if (strncmp(line, "processor", 9) == 0) cpuCount++;
            if (strncmp(line, "model name", 10) == 0 && cpuCount == 1) {
                char *colon = strchr(line, ':');
                if (colon) printf("Processor: %s", colon + 2);
            }
        }
        printf("CPU cores: %d\n", cpuCount);
        fclose(fp);
    }
fp = fopen("/proc/meminfo", "r");
    if (fp) {
        char line[256];
        long totalMem = 0;
        while (fgets(line, sizeof(line), fp)) {
            if (strncmp(line, "MemTotal:", 9) == 0) {
                sscanf(line, "MemTotal: %ld kB", &totalMem);
                printf("RAM: %.2f GB\n", totalMem / (1024.0 * 1024.0));
                break;
            }
        }
        fclose(fp);
    }

#elif APPLE
    printf("Operating System: macOS\n");

    struct utsname kernelInfo;
    if (uname(&kernelInfo) == 0) {
        printf("Kernel: %s %s\n", kernelInfo.sysname, kernelInfo.release);
        printf("Architecture: %s\n", kernelInfo.machine);
    }
    printf("(Detailed macOS version is not detected in this version of the program)\n");

#else
    printf("Operating System: Unknown\n");
#endif
    return 0;
}
