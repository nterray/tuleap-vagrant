name 'tuleap'
description 'A Tuleap instance'
run_list 'recipe[tuleap::rpm_deployment]'
default_attributes 'tuleap' => {'repo' => 'stable'}
