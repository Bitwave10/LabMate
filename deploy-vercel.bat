@echo off
REM ========================================
REM Vercel 배포 스크립트
REM ========================================

echo ========================================
echo Vercel 배포 설정 시작
echo ========================================

REM 1. Vercel CLI 설치 확인
echo.
echo 1. Vercel CLI 설치 상태 확인 중...
vercel --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Vercel CLI가 설치되지 않았습니다. 설치 중...
    npm install -g vercel
    if %errorlevel% neq 0 (
        echo 오류: Vercel CLI 설치 실패
        echo 수동 설치: npm install -g vercel
        pause
        exit /b 1
    )
)

REM 2. 로컬 빌드 테스트
echo.
echo 2. 로컬 빌드 테스트 중...
npm run build
if %errorlevel% neq 0 (
    echo 오류: 빌드 실패
    pause
    exit /b 1
)

REM 3. Vercel 로그인 확인
echo.
echo 3. Vercel 로그인 상태 확인 중...
vercel whoami >nul 2>&1
if %errorlevel% neq 0 (
    echo Vercel 로그인이 필요합니다.
    echo 브라우저에서 로그인을 완료해주세요.
    vercel login
    if %errorlevel% neq 0 (
        echo 오류: Vercel 로그인 실패
        pause
        exit /b 1
    )
)

REM 4. Vercel 프로젝트 배포
echo.
echo 4. Vercel에 프로젝트 배포 중...
echo 프로젝트 설정 질문에 다음과 같이 답변하세요:
echo - Set up and deploy? Y
echo - Which scope? (기본값 사용)
echo - Link to existing project? N
echo - What's your project's name? labmate-app
echo - In which directory is your code located? ./
echo.
vercel --prod
if %errorlevel% neq 0 (
    echo 오류: Vercel 배포 실패
    pause
    exit /b 1
)

REM 5. GitHub 연동 (선택사항)
echo.
echo ========================================
echo GitHub 자동 배포 연동 설정 (선택사항)
echo ========================================
echo.
set /p LINK_GITHUB="GitHub 저장소와 자동 배포를 연동하시겠습니까? (y/n): "
if /i "%LINK_GITHUB%"=="y" (
    echo GitHub 연동 중...
    vercel --github
    if %errorlevel% neq 0 (
        echo 경고: GitHub 연동 실패 (수동으로 설정 가능)
    )
)

echo.
echo ========================================
echo ✅ Vercel 배포 완료!
echo ========================================
echo.
echo 배포된 URL을 확인하세요:
echo 1. Vercel 대시보드: https://vercel.com/dashboard
echo 2. 또는 배포 완료 메시지에서 제공된 URL
echo.
echo 다음 배포부터는 GitHub에 푸시할 때마다 자동으로 배포됩니다.
echo.
pause
