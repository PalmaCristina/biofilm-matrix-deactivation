function o=fglobal(gr,pos)
  o=2.^(0.95.*(1.1-gr)).*2.^(gr./0.69.*(0.69./gr-(0.78+0.15./gr).*pos));
  % o=2.^(0.95.*(1.1-gr));
end