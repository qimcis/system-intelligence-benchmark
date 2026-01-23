#!/usr/bin/env python3
"""
Web UI for adding OSTEP labs to courselab_bench.

Run with: python3 lab_ui.py
Then open: http://localhost:5050
"""

import json
import sys
from pathlib import Path

try:
    from flask import Flask, render_template_string, request, jsonify
except ImportError:
    print("Flask not installed. Install with: pip install flask")
    sys.exit(1)

sys.path.insert(0, str(Path(__file__).parent))
from add_ostep_lab import add_ostep_lab, detect_lab_type, detect_test_script, get_commit_hash

app = Flask(__name__)

HTML_TEMPLATE = """
<!DOCTYPE html>
<html>
<head>
    <title>OSTEP Lab Addition Tool</title>
    <style>
        * { box-sizing: border-box; }
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            background: #f5f5f5;
        }
        h1 { color: #333; border-bottom: 2px solid #007acc; padding-bottom: 10px; }
        .card {
            background: white;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        label {
            display: block;
            margin-top: 15px;
            font-weight: 600;
            color: #333;
        }
        input, select {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }
        input:focus, select:focus {
            outline: none;
            border-color: #007acc;
        }
        button {
            background: #007acc;
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 20px;
            font-size: 16px;
            width: 100%;
        }
        button:hover { background: #005a9e; }
        button:disabled { background: #ccc; cursor: not-allowed; }
        .result {
            margin-top: 20px;
            padding: 15px;
            border-radius: 4px;
            white-space: pre-wrap;
            font-family: monospace;
            font-size: 13px;
        }
        .success { background: #d4edda; border: 1px solid #c3e6cb; color: #155724; }
        .error { background: #f8d7da; border: 1px solid #f5c6cb; color: #721c24; }
        .info { background: #e7f3ff; border: 1px solid #b6d4fe; color: #084298; }
        .hint {
            font-size: 12px;
            color: #666;
            margin-top: 4px;
        }
        .lab-list {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 8px;
            margin-top: 10px;
        }
        .lab-item {
            background: #f8f9fa;
            padding: 8px 12px;
            border-radius: 4px;
            font-family: monospace;
            font-size: 13px;
            cursor: pointer;
        }
        .lab-item:hover { background: #e9ecef; }
        h3 { margin-top: 0; color: #495057; }
    </style>
</head>
<body>
    <h1>OSTEP Lab Addition Tool</h1>

    <div class="card">
        <h3>Repository Settings</h3>
        <label>GitHub URL</label>
        <input type="text" id="github_url" value="https://github.com/remzi-arpacidusseau/ostep-projects">

        <label>Local Clone Path (optional, faster)</label>
        <input type="text" id="local_repo" placeholder="/home/qi/ostep-projects">
        <p class="hint">Leave empty to clone fresh from GitHub</p>
    </div>

    <div class="card">
        <h3>Lab Selection</h3>
        <label>Lab Path</label>
        <input type="text" id="lab_path" placeholder="e.g., processes-shell or initial-utilities/wcat">

        <p class="hint">Common OSTEP labs (click to select):</p>
        <div class="lab-list">
            <div class="lab-item" onclick="selectLab('initial-utilities/wcat')">initial-utilities/wcat</div>
            <div class="lab-item" onclick="selectLab('initial-utilities/wgrep')">initial-utilities/wgrep</div>
            <div class="lab-item" onclick="selectLab('initial-utilities/wzip')">initial-utilities/wzip</div>
            <div class="lab-item" onclick="selectLab('initial-utilities/wunzip')">initial-utilities/wunzip</div>
            <div class="lab-item" onclick="selectLab('initial-reverse')">initial-reverse</div>
            <div class="lab-item" onclick="selectLab('processes-shell')">processes-shell</div>
            <div class="lab-item" onclick="selectLab('concurrency-webserver')">concurrency-webserver</div>
            <div class="lab-item" onclick="selectLab('concurrency-pzip')">concurrency-pzip</div>
            <div class="lab-item" onclick="selectLab('concurrency-mapreduce')">concurrency-mapreduce</div>
            <div class="lab-item" onclick="selectLab('filesystems-checker')">filesystems-checker</div>
        </div>
    </div>

    <div class="card">
        <h3>Course Settings</h3>
        <label>Course ID</label>
        <input type="text" id="course_id" value="cs537-ostep">

        <label>Course Name</label>
        <input type="text" id="course_name" value="UW-Madison CS537: Operating Systems (OSTEP)">

        <label>Institution</label>
        <input type="text" id="institution" value="UW-Madison">

        <label>Timeout (minutes)</label>
        <input type="number" id="timeout" value="20">
    </div>

    <div class="card">
        <button onclick="addLab()" id="addBtn">Add Lab</button>
        <button onclick="previewLab()" id="previewBtn" style="background: #6c757d; margin-top: 10px;">Preview (Dry Run)</button>
        <div id="result"></div>
    </div>

    <script>
        function selectLab(path) {
            document.getElementById('lab_path').value = path;
        }

        async function addLab(dryRun = false) {
            const btn = dryRun ? document.getElementById('previewBtn') : document.getElementById('addBtn');
            const resultDiv = document.getElementById('result');

            btn.disabled = true;
            btn.textContent = dryRun ? 'Previewing...' : 'Adding...';
            resultDiv.className = 'result info';
            resultDiv.textContent = 'Processing...';

            const data = {
                github_url: document.getElementById('github_url').value,
                local_repo: document.getElementById('local_repo').value || null,
                lab_path: document.getElementById('lab_path').value,
                course_id: document.getElementById('course_id').value,
                course_name: document.getElementById('course_name').value,
                institution: document.getElementById('institution').value,
                timeout: parseInt(document.getElementById('timeout').value),
                dry_run: dryRun
            };

            try {
                const response = await fetch('/add_lab', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/json'},
                    body: JSON.stringify(data)
                });
                const result = await response.json();

                if (result.success) {
                    resultDiv.className = 'result success';
                    resultDiv.textContent = result.message;
                } else {
                    resultDiv.className = 'result error';
                    resultDiv.textContent = 'Error: ' + result.error;
                }
            } catch (e) {
                resultDiv.className = 'result error';
                resultDiv.textContent = 'Error: ' + e.message;
            }

            btn.disabled = false;
            btn.textContent = dryRun ? 'Preview (Dry Run)' : 'Add Lab';
        }

        function previewLab() {
            addLab(true);
        }
    </script>
</body>
</html>
"""

@app.route('/')
def index():
    return render_template_string(HTML_TEMPLATE)

@app.route('/add_lab', methods=['POST'])
def add_lab_endpoint():
    try:
        data = request.json

        # Capture output
        import io
        from contextlib import redirect_stdout

        output = io.StringIO()
        with redirect_stdout(output):
            add_ostep_lab(
                github_url=data['github_url'],
                lab_path_str=data['lab_path'],
                course_id=data['course_id'],
                course_name=data['course_name'],
                institution=data['institution'],
                timeout_minutes=data.get('timeout', 20),
                local_repo=data.get('local_repo'),
                dry_run=data.get('dry_run', False),
            )

        return jsonify({
            'success': True,
            'message': output.getvalue()
        })
    except Exception as e:
        return jsonify({
            'success': False,
            'error': str(e)
        })

@app.route('/list_labs')
def list_labs():
    """List existing labs."""
    data_dir = Path(__file__).parent / 'data'
    labs = []
    for course_dir in data_dir.iterdir():
        if course_dir.is_dir() and course_dir.name != 'courses.json':
            for task_dir in course_dir.iterdir():
                if task_dir.is_dir() and (task_dir / 'config.json').exists():
                    with open(task_dir / 'config.json') as f:
                        config = json.load(f)
                    labs.append({
                        'instance_id': config.get('instance_id'),
                        'course_id': config.get('course_id'),
                        'path': str(task_dir.relative_to(data_dir))
                    })
    return jsonify(labs)


if __name__ == '__main__':
    print("=" * 50)
    print("OSTEP Lab Addition UI")
    print("=" * 50)
    print("\nOpen in browser: http://localhost:5050")
    print("Press Ctrl+C to stop\n")
    app.run(host='0.0.0.0', port=5050, debug=True)
