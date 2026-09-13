# Podcaster Skill Suite

Reusable agent workflows for producing a UK–Taiwan film and entertainment podcast: topic research, audio rough cuts, reference-driven Reels, captions, multi-agent handoffs, and editable Final Cut Pro projects.

## Install from GitHub

After this repository is pushed to GitHub, install the podcast skill with the `skills` CLI:

```bash
npx skills@latest add YOUR_GITHUB_USER/podcaster-skill-suite \
  --skill podcast-production \
  --agent codex \
  --global \
  --copy \
  --yes
```

Options:

- `--skill podcast-production` installs only this skill.
- `--agent codex` targets Codex. Omit it to choose interactively or target another supported agent.
- `--global` installs for the current user. Omit it to install in the current project.
- `--copy` copies the files instead of creating symlinks.
- `--yes` makes the command non-interactive and suitable for setup scripts.

To preview what the repository exposes:

```bash
npx skills@latest add YOUR_GITHUB_USER/podcaster-skill-suite --list
```

To update an installed version:

```bash
npx skills update podcast-production
```

The CLI supports GitHub shorthand, full GitHub URLs, and direct skill paths. The current skill is at `podcast-production/SKILL.md`, so this direct-path form can be used if the repository is not yet using the standard `skills/` catalog layout:

```bash
npx skills@latest add \
  https://github.com/YOUR_GITHUB_USER/podcaster-skill-suite/tree/main/podcast-production \
  --agent codex --global --copy --yes
```

For a multi-skill repository, the most discoverable layout is:

```text
skills/
  podcast-production/
    SKILL.md
    agents/
    references/
    scripts/
```

## Local development

Install the current checkout into Codex while testing changes:

```bash
npx skills@latest add . \
  --skill podcast-production \
  --agent codex \
  --global \
  --copy \
  --yes
```

Validate the skill and helper scripts:

```bash
python3 /path/to/skill-creator/scripts/quick_validate.py podcast-production
bash -n podcast-production/scripts/*.sh
./podcast-production/scripts/inspect_media.sh PATH/TO/MEDIA
```

The reel helpers accept explicit input and output paths. They require FFmpeg; editable Final Cut layer generation also requires macOS Quick Look (`qlmanage`).

## Output files

All episode inputs and generated media belong in the local, Git-ignored `output/` folder:

```text
output/
  input/
  audio/
  captions/
  reels/
  final-cut/
  review/
  notes/
```

Do not commit audio, video, images, FCPXML exports, ZIP packages, or temporary renders unless a specific artifact is intentionally being versioned. Commit the skill instructions, references, reusable scripts, and documentation instead.

## What the skill supports

- Topic development for UK–Taiwan film and entertainment episodes.
- Rough-cut and speech-first audio post-processing for long recordings.
- Highlight selection and captioned 9:16 Reel production.
- Reference Reel breakdown into layers, typography, captions, timing, and animation keyframes.
- Multi-agent production with coordinator ownership, artifact handoffs, and episode-scoped output.
- Editable Final Cut Pro exports with frame-aligned captions, separate avatar/foreground/background layers, and an import smoke test.

See [podcast-production/SKILL.md](podcast-production/SKILL.md) for the main workflow and [podcast-production/references/multi-agent.md](podcast-production/references/multi-agent.md) for handoffs between agents.
