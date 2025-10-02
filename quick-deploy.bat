@echo off
REM ========================================
REM 🚀 원클릭 배포 스크립트
REM LabMate Base44 → GitHub → Vercel 자동 배포
REM ========================================

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                    🚀 LabMate Base44 배포                    ║
echo ║                GitHub + Vercel 원클릭 배포                   ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.

REM 현재 디렉토리 확인
echo 📁 현재 프로젝트: %CD%
echo.

REM 1. Git 상태 확인
echo 🔍 Git 상태 확인 중...
if not exist ".git" (
    echo ❌ Git 저장소가 초기화되지 않았습니다.
    echo 📝 Git 초기화를 진행합니다...
    call git-setup.bat
    if %errorlevel% neq 0 (
        echo ❌ Git 설정 실패
        pause
        exit /b 1
    )
) else (
    echo ✅ Git 저장소 확인됨
)

REM 2. 빌드 테스트
echo.
echo 🏗️  빌드 테스트 중...
call test-build.bat
if %errorlevel% neq 0 (
    echo ❌ 빌드 테스트 실패
    pause
    exit /b 1
)

REM 3. 배포 방법 선택
echo.
echo ========================================
echo 📋 배포 방법을 선택하세요
echo ========================================
echo.
echo 1. Vercel 배포 (추천 - 빠르고 간단)
echo 2. GitHub Pages 배포 (무료, 설정 복잡)
echo 3. 둘 다 배포
echo.
set /p DEPLOY_CHOICE="선택 (1/2/3): "

if "%DEPLOY_CHOICE%"=="1" (
    echo.
    echo 🚀 Vercel 배포 시작...
    call deploy-vercel.bat
) else if "%DEPLOY_CHOICE%"=="2" (
    echo.
    echo 🌐 GitHub Pages 배포 시작...
    call deploy-github-pages.bat
) else if "%DEPLOY_CHOICE%"=="3" (
    echo.
    echo 🚀 Vercel 배포 시작...
    call deploy-vercel.bat
    echo.
    echo 🌐 GitHub Pages 배포 시작...
    call deploy-github-pages.bat
) else (
    echo ❌ 잘못된 선택입니다.
    pause
    exit /b 1
)

REM 4. 최종 확인
echo.
echo ========================================
echo ✅ 배포 완료!
echo ========================================
echo.
echo 📋 다음 단계:
echo 1. 배포된 URL에서 애플리케이션 확인
echo 2. 모든 기능 정상 작동 테스트
echo 3. 모바일에서도 접속 테스트
echo.
echo 🔄 코드 수정 후 재배포:
echo    git add . ^&^& git commit -m "Update" ^&^& git push
echo.
echo 📖 자세한 가이드: DEPLOYMENT_GUIDE.md 파일 참조
echo.
pause
