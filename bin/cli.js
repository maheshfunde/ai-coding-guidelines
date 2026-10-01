#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const os = require('os');
const readline = require('readline');

const rootDir = path.resolve(__dirname, '..');
const homeDir = os.homedir();
const cwd = process.cwd();

function copyRecursiveSync(src, dest) {
  const exists = fs.existsSync(src);
  const stats = exists && fs.statSync(src);
  const isDirectory = exists && stats.isDirectory();
  if (isDirectory) {
    if (!fs.existsSync(dest)) {
      fs.mkdirSync(dest, { recursive: true });
    }
    fs.readdirSync(src).forEach((childItemName) => {
      copyRecursiveSync(path.join(src, childItemName), path.join(dest, childItemName));
    });
  } else if (exists) {
    const parentDir = path.dirname(dest);
    if (!fs.existsSync(parentDir)) {
      fs.mkdirSync(parentDir, { recursive: true });
    }
    fs.copyFileSync(src, dest);
  }
}

function installAntigravity() {
  const target = path.join(homeDir, '.gemini', 'config', 'skills');
  const src = path.join(rootDir, 'skills');
  copyRecursiveSync(src, target);
  console.log('\x1b[32m✔\x1b[0m Installed for Antigravity IDE globally: ' + target);
}

function installClaudeCode() {
  const target = path.join(homeDir, '.claude', 'skills');
  const src = path.join(rootDir, 'skills');
  copyRecursiveSync(src, target);
  console.log('\x1b[32m✔\x1b[0m Installed for Claude Code globally: ' + target);
}

function installWorkspace(projectPath = cwd) {
  // 1. Antigravity .agents/skills
  copyRecursiveSync(path.join(rootDir, 'skills'), path.join(projectPath, '.agents', 'skills'));

  // 2. Cursor .cursor/rules and .cursorrules
  copyRecursiveSync(path.join(rootDir, '.cursor', 'rules'), path.join(projectPath, '.cursor', 'rules'));
  fs.copyFileSync(path.join(rootDir, '.cursorrules'), path.join(projectPath, '.cursorrules'));

  // 3. Claude Code CLAUDE.md
  fs.copyFileSync(path.join(rootDir, 'CLAUDE.md'), path.join(projectPath, 'CLAUDE.md'));

  // 4. GitHub Copilot
  copyRecursiveSync(path.join(rootDir, '.github'), path.join(projectPath, '.github'));

  // 5. Windsurf & Cline
  fs.copyFileSync(path.join(rootDir, '.windsurfrules'), path.join(projectPath, '.windsurfrules'));
  fs.copyFileSync(path.join(rootDir, '.clinerules'), path.join(projectPath, '.clinerules'));

  console.log('\x1b[32m✔\x1b[0m Configured current workspace: ' + projectPath);
  console.log('    - Antigravity: .agents/skills/');
  console.log('    - Cursor: .cursor/rules/ & .cursorrules');
  console.log('    - Claude Code: CLAUDE.md');
  console.log('    - GitHub Copilot: .github/copilot-instructions.md');
  console.log('    - Windsurf & Cline: .windsurfrules, .clinerules');
}

function printHeader() {
  console.log('\n\x1b[36m========================================================\x1b[0m');
  console.log('\x1b[33m       AI Coding Guidelines & Architecture Kit        \x1b[0m');
  console.log('\x1b[36m========================================================\x1b[0m');
  console.log('Works with: Antigravity, Claude Code, Cursor, Copilot, Windsurf\n');
}

const args = process.argv.slice(2);

if (args.includes('--all') || args.includes('-a')) {
  printHeader();
  installAntigravity();
  installClaudeCode();
  installWorkspace();
  console.log('\n\x1b[36mAll AI targets configured successfully!\x1b[0m\n');
  process.exit(0);
}

if (args.includes('--antigravity')) {
  printHeader();
  installAntigravity();
  process.exit(0);
}

if (args.includes('--claude')) {
  printHeader();
  installClaudeCode();
  process.exit(0);
}

if (args.includes('--workspace') || args.includes('-w')) {
  printHeader();
  installWorkspace();
  process.exit(0);
}

// Interactive prompt
printHeader();
const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

console.log('Where would you like to install the guidelines?');
console.log('  1) Antigravity IDE (Global ~/.gemini/config/skills)');
console.log('  2) Claude Code (Global ~/.claude/skills)');
console.log('  3) Current Project Workspace (Cursor, Claude, Copilot, Windsurf, Antigravity)');
console.log('  4) Everything (Global + Current Project)');
console.log('  q) Quit\n');

rl.question('Select an option [1-4]: ', (answer) => {
  rl.close();
  switch (answer.trim()) {
    case '1':
      installAntigravity();
      break;
    case '2':
      installClaudeCode();
      break;
    case '3':
      installWorkspace();
      break;
    case '4':
      installAntigravity();
      installClaudeCode();
      installWorkspace();
      console.log('\n\x1b[36mAll targets configured successfully!\x1b[0m');
      break;
    default:
      console.log('No changes made.');
  }
});