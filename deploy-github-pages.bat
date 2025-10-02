@echo off
REM ========================================
REM GitHub Pages 배포 스크립트
REM ========================================

echo ========================================
echo GitHub Pages 배포 설정 시작
echo ========================================

REM 1. GitHub Pages용 vite.config.js 복사
echo.
echo 1. GitHub Pages용 설정 파일 적용 중...
copy vite.config.pages.js vite.config.js
if %errorlevel% neq 0 (
    echo 오류: 설정 파일 복사 실패
    pause
    exit /b 1
)

REM 2. 빌드 테스트
echo.
echo 2. 로컬 빌드 테스트 중...
npm run build
if %errorlevel% neq 0 (
    echo 오류: 빌드 실패
    echo 원본 설정으로 복원합니다...
    git checkout vite.config.js
    pause
    exit /b 1
)

REM 3. 빌드 결과 미리보기
echo.
echo 3. 빌드 결과 미리보기 실행 중...
echo 브라우저에서 http://localhost:4173 접속하여 확인하세요.
echo 확인 완료 후 아무 키나 눌러 계속하세요...
npm run preview
pause

REM 4. 변경사항 커밋 및 푸시
echo.
echo 4. GitHub Pages 설정 커밋 및 푸시 중...
git add .
git commit -m "Configure GitHub Pages deployment"
git push origin main
if %errorlevel% neq 0 (
    echo 오류: 푸시 실패
    pause
    exit /b 1
)

echo.
echo ========================================
echo ✅ GitHub Pages 배포 설정 완료!
echo ========================================
echo.
echo 다음 단계:
echo 1. GitHub 저장소 → Settings → Pages 이동
echo 2. Source: GitHub Actions 선택
echo 3. 배포 완료 후 https://[사용자명].github.io/labmate-app/ 접속
echo.
echo ⚠️  주의: GitHub Pages 설정이 완료되려면 몇 분이 걸릴 수 있습니다.
echo.
pause
