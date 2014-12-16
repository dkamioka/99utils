def run_this(input,output)
  File.open(output, "wb") do |f| 
    File.foreach(input) do |line| 
      arr = line.split(",")
      slug = arr.first
      name = Company.find_by_slug(slug).name if Company.find_by_slug(slug)
      views = arr[1]
      f.write [slug,name,views].join(",")
    end
  end
end