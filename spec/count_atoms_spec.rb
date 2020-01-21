require "count_atoms"

describe "#should_return_hash" do
  it "should return an empty hash when giving empty string" do
    expect( count_atoms('') ).to eq({})
  end

  it "should return the right hash for H" do
    expect( count_atoms('H') ).to eq({"H" => 1})
  end

  it "should return the right hash for H20" do
    expect( count_atoms('H2O') ).to eq({"H" => 2,"O" => 1})
  end

  it "should return the right hash for Mg(OH)2" do
    expect( count_atoms('Mg(OH)2') ).to eq({"Mg" => 1,"O" => 2, "H" => 2})
  end

  it "should return the right hash for K4[ON(SO3)2]2" do
    expect( count_atoms('K4[ON(SO3)2]2') ).to eq({"K" => 4,"O" => 14, "N" => 2, "S" => 4})
  end

  it "should return the right hash for Mg1[(O)2(K2)3]4(SO)" do
    expect( count_atoms('Mg1[(O)2(K2)]4(SO)') ).to eq({"Mg" => 1,"O" => 9, "K" => 8, "S" => 1})
  end
end

