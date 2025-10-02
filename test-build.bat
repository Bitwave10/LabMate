@echo off
REM ========================================
REM 로컬 빌드 테스트 스크립트
REM ========================================

echo ========================================
echo 로컬 빌드 및 미리보기 테스트
echo ========================================

REM 1. 의존성 설치 확인
echo.
echo 1. 의존성 설치 상태 확인 중...
if not exist "node_modules" (
    echo node_modules가 없습니다. 의존성 설치 중...
    npm install
    if %errorlevel% neq 0 (
        echo 오류: 의존성 설치 실패
        pause
        exit /b 1
    )
)

REM 2. 빌드 실행
echo.
echo 2. 프로덕션 빌드 실행 중...
npm run build
if %errorlevel% neq 0 (
    echo 오류: 빌드 실패
    echo 빌드 로그를 확인하고 오류를 수정해주세요.
    pause
    exit /b 1
)

echo ✅ 빌드 성공!

REM 3. 미리보기 서버 실행
echo.
echo 3. 미리보기 서버 시작 중...
echo.
echo ========================================
echo 🌐 브라우저에서 http://localhost:4173 접속
echo ========================================
echo.
echo 미리보기 서버가 실행되었습니다.
echo 브라우저에서 애플리케이션을 확인하세요.
echo.
echo 종료하려면 Ctrl+C를 누르세요.
echo.

npm run preview

pause
