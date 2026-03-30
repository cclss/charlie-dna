# AGENTS.md

> STATUS: CONFIRMED

This project uses the Charlie system.
이 프로젝트는 Charlie 시스템을 사용한다.

This file is the first entry point read by the Agent CLI.
이 파일은 Agent CLI가 가장 먼저 읽는 진입점이다.

---

## Startup

1. Check `.charlie/override/`. If an active override exists, follow it first.
   `.charlie/override/` 를 확인하라. 활성화된 override가 있으면 우선 따른다.
2. Read `.charlie/principal/INDEX.md`.
   `.charlie/principal/INDEX.md` 를 읽어라.
3. Read the necessary files in the order specified by INDEX.md.
   INDEX.md가 안내하는 순서대로 필요한 파일을 읽어라.
4. Check the STATUS of every file. Do not reference any file whose STATUS is not CONFIRMED.
   모든 파일의 STATUS를 확인하라. CONFIRMED가 아닌 파일은 참조하지 마라.

---

## Commands — 명령어

### /onboard

Initial project setup. One-time only.
프로젝트 초기 구성. 일회성.

1. Read and follow `.charlie/principal/skills/onboard/SKILL.md`.
   `.charlie/principal/skills/onboard/SKILL.md` 를 읽고 따른다.
2. Required input: `.charlie/context/masterplan.md`
   필수 입력: `.charlie/context/masterplan.md`
3. Optional input: additional materials passed via `--context`.
   선택 입력: `--context` 로 전달된 추가 자료.

### /done

End of session.
세션 종료.

1. Read and follow `.charlie/principal/skills/handoff/SKILL.md`.
   `.charlie/principal/skills/handoff/SKILL.md` 를 읽고 따른다.

### /fix

Fix items that the reviewer marked as FAIL.
reviewer가 FAIL 판정한 항목을 수정한다.

1. Read `.charlie/context/runs/{session-id}/fix-plan.md`.
   `.charlie/context/runs/{session-id}/fix-plan.md` 를 읽는다.
2. Re-execute only the scope specified by fix-plan, following `.charlie/principal/skills/implement/SKILL.md`.
   fix-plan이 지시하는 범위만 `.charlie/principal/skills/implement/SKILL.md` 를 따라 재실행한다.

---

## Immutable — 수정 불가

The following directories must never be modified.
These files are only changed via `charlie dna update`.
다음 디렉토리의 파일은 절대 수정하지 않는다.
이 파일들은 `charlie dna update` 로만 변경된다.

- `.charlie/principal/`
- `.charlie/agents/`

---

## Golden Rules — 골든 룰

- Do not proceed based on anything that is not confirmed.
  확정되지 않은 것을 기반으로 다음을 진행하지 마라.
- Do not fill in blanks with guesses.
  추측으로 빈 칸을 채우지 마라.
- If you don't know, stop and ask.
  모르면 멈추고 물어라.
