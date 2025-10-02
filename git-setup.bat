@echo off
REM ========================================
REM Git 초기화 및 GitHub 업로드 스크립트
REM ========================================

echo ========================================
echo Git 초기화 및 GitHub 업로드 시작
echo ========================================

REM 1. Git 저장소 초기화
echo.
echo 1. Git 저장소 초기화 중...
git init
if %errorlevel% neq 0 (
    echo 오류: Git 초기화 실패
    pause
    exit /b 1
)

REM 2. 모든 파일 추가
echo.
echo 2. 파일들을 Git에 추가 중...
git add .
if %errorlevel% neq 0 (
    echo 오류: 파일 추가 실패
    pause
    exit /b 1
)

REM 3. 첫 번째 커밋
echo.
echo 3. 첫 번째 커밋 생성 중...
git commit -m "Initial commit: LabMate Base44 React + Vite 웹앱"
if %errorlevel% neq 0 (
    echo 오류: 커밋 생성 실패
    pause
    exit /b 1
)

REM 4. 메인 브랜치 설정 (GitHub 기본 브랜치명)
echo.
echo 4. 메인 브랜치 설정 중...
git branch -M main
if %errorlevel% neq 0 (
    echo 오류: 브랜치 설정 실패
    pause
    exit /b 1
)

REM 5. GitHub 저장소 연결 (사용자가 생성한 저장소 URL 입력 필요)
echo.
echo ========================================
echo GitHub 저장소 연결 설정
echo ========================================
echo.
echo GitHub에서 'labmate-app' 저장소를 생성했는지 확인하세요.
echo 저장소 URL은 다음과 같은 형식입니다:
echo https://github.com/[사용자명]/labmate-app.git
echo.
set /p REPO_URL="GitHub 저장소 URL을 입력하세요: "

if "%REPO_URL%"=="" (
    echo 오류: 저장소 URL이 입력되지 않았습니다.
    echo 스크립트를 다시 실행해주세요.
    pause
    exit /b 1
)

echo.
echo 5. GitHub 원격 저장소 연결 중...
git remote add origin %REPO_URL%
if %errorlevel% neq 0 (
    echo 오류: 원격 저장소 연결 실패
    echo 이미 연결된 저장소일 수 있습니다. 기존 연결을 확인합니다...
    git remote -v
    pause
    exit /b 1
)

REM 6. GitHub에 푸시
echo.
echo 6. GitHub에 코드 업로드 중...
git push -u origin main
if %errorlevel% neq 0 (
    echo 오류: GitHub 업로드 실패
    echo GitHub 저장소가 올바르게 생성되었는지 확인하세요.
    pause
    exit /b 1
)

echo.
echo ========================================
echo ✅ GitHub 업로드 완료!
echo ========================================
echo.
echo 저장소 URL: %REPO_URL%
echo.
echo 다음 단계:
echo 1. GitHub Pages 또는 Vercel 배포 설정
echo 2. deploy-github-pages.bat 또는 deploy-vercel.bat 실행
echo.
pause
