DATE="2021-01-01"

charts-syncer sync --config tac.yaml --from-date $DATE
charts-syncer sync --config bitnami.yaml --from-date $DATE
charts-syncer sync --config concourse.yaml --from-date $DATE
charts-syncer sync --config jetstack.yaml --from-date $DATE

