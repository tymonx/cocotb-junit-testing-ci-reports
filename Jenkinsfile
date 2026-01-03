// SPDX-FileCopyrightText: 2026 Tymoteusz Blazejczyk <tymoteusz.blazejczyk@tymonx.com>
// SPDX-License-Identifier: Apache-2.0

// Installed plugins:
// - xunit
// - junit
// - junit-attachments

// Docker Workflow plugin is useless. It doesn't work with rootless containers with Podman or even with Docker.
// https://github.com/jenkinsci/docker-workflow-plugin/issues/716

// Node with installed podman remote as podman and configured with the CONTAINER_HOST environment variable:
// - unix:///run/podman/podman.sock
// - tcp://<host>:<port>
node {
    git url: 'https://github.com/tymonx/cocotb-junit-testing-ci-reports.git', branch: 'main'
    try {
        sh 'podman run --rm --volume ${WORKSPACE}:${WORKSPACE} --workdir ${WORKSPACE} registry.gitlab.com/tymonx/ghdl:latest make test-with-runner'
    } finally {
        junit testDataPublishers: [[$class: 'AttachmentPublisher']], testResults: '**/*.result.xml'
    }
}
