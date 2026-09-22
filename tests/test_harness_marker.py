from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent


def test_no_fail_build_marker():
    assert not (REPO_ROOT / "FAIL_BUILD").exists()
