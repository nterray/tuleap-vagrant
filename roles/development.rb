name 'development'
description 'Tuleap development environment'
run_list 'recipe[tuleap::development]',
         'recipe[tuleap::packaging]'
