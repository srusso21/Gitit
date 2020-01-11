function Out-Array
{
  begin
  {
    $output = @();
  }
  process
  {
    $output += $_;
  }
  end
  {
    return ,$output;
  }
}