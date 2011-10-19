#!  /usr/bin/env ruby

require 'rubygems'
require 'hpricot'
require 'pagina'

class String
    def with0 len = 3
        if len.class != 0.class then
            return with0(len.length)
        else
            (self.reverse + ('0' * len))[0, len].reverse
        end
    end
end

def gmain args
    if args.length < 3 then
        STDERR.puts(%[#{$0} template dir bible1.xml bible2.xml ...])
        return 1
    else
        unless File.exists?(args.first)
            STDERR.puts(%[Template missing (at #{args.first})])
            return 2
        end
        if File.directory?(args[1]) then
            doc = File.open(args[2]){|f| Hpricot::XML(f)}
            File.open(args.first, 'r') do |tept|
                tpt = tept.read
                Dir.chdir(args[1]) do
                    (doc / 'BIBLEBOOK').each do |bk|
                        dnm = %[#{bk['bnumber'].with0(2)} #{bk['bname']}]
                        Dir.mkdir(dnm) unless File.directory?(dnm)
                        chps = (bk / 'CHAPTER')
                        oln  = (chps.length > 99 ? 3 : chps.length < 10 ? 1 : 2)
                        pag  = Pagina.new chps.length, 7
                        #   nav  = (1 .. chps.length).to_a.map {|x| %[<a href="./#{x.to_s.with0(oln)}.html">#{x}</a>]}.join(' &bull; ')
                        sfr  = 0
                        chps.each do |chp|
                            File.open("#{dnm}/#{chp['cnumber'].with0(oln)}.html", 'w') do |nv|
                                ctx = (chp / 'VERS').map {|x| %[<span class="v"><sup>#{x['vnumber']}</sup>#{x.inner_html.gsub("\n", '<br />')}</span>]}.join(' ')
                                fin = Hpricot::XML(tpt)
                                nom = [bk['bname'], chp['cnumber']]
                                (fin / 'title').inner_html  = nom.join(' ')
                                (fin / '#descr').inner_html = nom.join(' ')
                                (fin / '#dest').inner_html  = ctx
                                (fin / '.nav').inner_html   = pag.nav(chp['cnumber'].to_i, ' &bull; ', ' &#133; ') {|e, y| (y ? e.to_s : %[<a href="./#{e.to_s.with0(oln)}.html">#{e}</a>])}
                                nv.write(fin.to_s)
                                sfr = sfr + 1
                                STDOUT.print((((sfr.to_f / chps.length.to_f) * 100).round.to_s + '% ') + nom.join(', ') + (' ' * 60) + "\r")
                                STDOUT.flush
                            end
                        end
                    end
                end
            end
            0
        else
            Dir.mkdir args[1]
            return gmain(args)
        end
    end
rescue Errno::ENOENT => e
    $stderr.puts %[#{e.message} in current directory #{Dir.pwd}]
    1
end

exit(gmain(ARGV))
