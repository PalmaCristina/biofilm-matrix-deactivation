function n = config(varargin)
species=containers.Map;

for v=1:numel(varargin)
      reaction=varargin{v};

% Generate the code of a Dynamic system based on the reaction scheme
% Output: a function, generate dx given the reaction scheme. 
% Now, different files must have different parameter names(to do)
f=fopen(reaction);
mode='h';
p={};
head={};
while(f)
    line=fgetl(f);
    if line==-1
        break
    end
    line=strtrim(line);
    
   
    if isempty(line)||line(1) =='#'
        continue
    end
    % comments start with '#' and will be discarded
    
    if strcmp(line,'parameters:')
        mode='p';
        continue
    end
    % the defination of the parameters will be cpoied to the function file
    
    if strcmp(line,'reactions:')
        mode='r';
        continue
    end
    if mode=='h'
        head=[head,{line}];
        if length(line)>9 && strcmp(line(1:8),'function')
        name=strsplit(line,'=');
       out=strsplit(name{2},'(');
       out=out{1};
       name=strsplit(name{1},' ');
       name=name{2};
        end
        continue
    end
    % head text will be copied to the output file. 
    if(mode)=='p'
        p=[p,{line}];
        continue
    else
        line=strrep(line,';','');
    end
    
    if(mode)=='r'
        line=line(~isspace(line));
        temp=strsplit(line,'|');
        kenetics=temp{2};
        react=strsplit(temp{1},'->');
        left=strsplit(react{1},'+');
        right=strsplit(react{2},'+');
        for i =1:length(left)
            if left{i}
                ii=strsplit(left{i},'*');
                if length(ii)==1
                    ni=ii{1};
                    ki='1';
                else
                    ni=ii{2};
                    ki=ii{1};
                end
            if isKey(species,ni)
                species(ni)=[species(ni) '-' kenetics '*' ki];
            else
                species(ni)=['-' kenetics '*' ki];
            end
            end
        end
        for i =1:length(right)
            if right{i}
                 ii=strsplit(right{i},'*');
                if length(ii)==1
                    ni=ii{1};
                    ki='1';
                else
                    ni=ii{2};
                    ki=ii{1};
                end
                if isKey(species,ni)
                    species(ni)=[species(ni) '+' kenetics '*' ki];
                else
                    species(ni)=[kenetics '*' ki];
                end
            end
        end
    end
end
fclose(f);
end
f=fopen([out,'.m'],'w');
for i =1:length(head)
fprintf(f,'%s\n',head{i});
end
for i =1:length(p)
fprintf(f,'%s\n',p{i});
end
key=keys(species);
for i =1:length(key)
    fprintf(f,'%s(%d);\n',[key{i} '=' 'x'],i);
end
for i =1:length(key)
    fprintf(f,'%s(%d)=%s;\n',name,i,species(key{i}));

end
fprintf(f,'%s=%s'';\n',name,name);
fprintf(f,'end\n');
fclose(f);
n=length(key);
end


