name 'tuleap_packaging'
description 'Tuleap packaging environment'
run_list 'recipe[tuleap::rpm_deployment]', 'recipe[tuleap::packaging_tools]' #, 'recipe[tuleap::build]'
default_attributes 'tuleap' => {'repo' => 'local'}
