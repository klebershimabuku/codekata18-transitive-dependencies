require './kata18/dependencies'

describe Dependencies do
  it 'basic' do
    dep = Dependencies.new
    dep.add_direct('A', %w{ B C } )
    dep.add_direct('B', %w{ C E } )
    dep.add_direct('C', %w{ G   } )
    dep.add_direct('D', %w{ A F } )
    dep.add_direct('E', %w{ F   } )
    dep.add_direct('F', %w{ H   } )

    expect(dep.dependencies_for('A')).to eq(%w{ B C E F G H })
    expect(dep.dependencies_for('B')).to eq(%w{ C E F G H })
    expect(dep.dependencies_for('C')).to eq(%w{ G })
    expect(dep.dependencies_for('D')).to eq(%w{ A B C E F G H })
    expect(dep.dependencies_for('E')).to eq(%w{ F H })
    expect(dep.dependencies_for('F')).to eq(%w{ H })
  end

  xit 'cyclic' do
    dep = Dependencies.new
    dep.add_direct('A', 'B')
    dep.add_direct('B', 'C')
    dep.add_direct('C', 'A')

    expect(dep.dependencies_for('A')).to eq(%w{ B C })
    expect(dep.dependencies_for('B')).to eq(%w{ A C })
    expect(dep.dependencies_for('C')).to eq(%w{ A B })
  end
end
