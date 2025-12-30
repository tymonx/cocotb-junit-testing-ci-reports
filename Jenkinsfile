// SPDX-FileCopyrightText: 2025 Tymoteusz Blazejczyk <tymoteusz.blazejczyk@tymonx.com>
// SPDX-License-Identifier: Apache-2.0

pipeline {
    agent { docker { image 'registry.gitlab.com/tymonx/ghdl:latest' } }
    stages {
        stage('build') {
            steps {
                sh 'echo Hello'
            }
        }
    }
}
