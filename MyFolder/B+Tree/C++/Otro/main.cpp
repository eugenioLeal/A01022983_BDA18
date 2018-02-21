class BTreeNodes
{
public:
    BTreeNodes *R;
    BTreeNodes *L;
    int inside[1]={0};
    int numbers= 0;
    bool hasR= false;
    bool hasL= false;
    bool isRoot=false;
    BTreeNodes *F;
    BTreeNodes(BTreeNodes *f)
    {
        *F=*f;
    }

};

class BTree
{
    BTreeNodes *root;
    void insert(int n,BTreeNodes x)
    {

        ///if has no sons
        if(x.hasL== false&&x.hasR==false)
        {
            if(x.numbers==0)
            {
                x.inside[1]=n;
                x.numbers++;
            }
            if(x.numbers==1)
            {
                if(x.inside[1]>n)
                {
                    x.inside[0]=n;
                }
                else
                {
                    x.inside[1]=n;
                }
            }
            if(x.numbers==2)
            {
                  if(n<x.inside[0])
                  {
                      x.L=new BTreeNodes(x);
                      insert(n,*x.L);
                  }
                  if(n>x.inside[0])
                  {
                      if(n<x.inside[1])
                      {
                          if (x.isRoot)
                          {
                              int temp = x.inside[0];
                              x.inside[0] = n;
                              x.L = new BTreeNodes(x);
                              insert(temp, *x.L);
                          }
                          else
                          {
                              int temp = x.inside[0];
                              x.inside[0] = n;
                              insert(temp, *x.F);
                          }
                      }
                  }
                  if(n>x.inside[0])
                  {
                      if(n>x.inside[1])
                      {
                          x.R=new BTreeNodes(x);
                          insert(n,*x.R);
                      }
                  }
            }

        }




        ///if has left sons
        if(x.hasL== true&&x.hasR==false)
        {
            if(x.numbers==0)
            {
                x.inside[1]=n;
                x.numbers++;
            }
            if(x.numbers==1)
            {
                if(x.inside[1]>n)
                {
                    x.inside[0]=n;
                }
                else
                {
                    x.inside[1]=n;
                }
            }
            if(x.numbers==2)
            {
                if(n<x.inside[0])
                {
                    insert(n,*x.L);
                }
                if(n>x.inside[0])
                {
                    if(n<x.inside[1])
                    {
                        if (x.isRoot)
                        {
                            int temp = x.inside[0];
                            x.inside[0] = n;
                            insert(temp, *x.L);
                        }
                        else
                        {
                            int temp = x.inside[0];
                            x.inside[0] = n;
                            insert(temp, *x.F);
                        }
                    }
                }
                if(n>x.inside[0])
                {
                    if(n>x.inside[1])
                    {
                        x.R=new BTreeNodes(x);
                        insert(n,*x.R);
                    }
                }
            }

        }




        ///if has right sons
        if(x.hasL== false&&x.hasR==true)
        {
            if(x.numbers==0)
            {
                x.inside[1]=n;
                x.numbers++;
            }
            if(x.numbers==1)
            {
                if(x.inside[1]>n)
                {
                    x.inside[0]=n;
                }
                else
                {
                    x.inside[1]=n;
                }
            }
            if(x.numbers==2)
            {
                if(n<x.inside[0])
                {
                    x.L=new BTreeNodes(x);
                    insert(n,*x.L);
                }
                if(n>x.inside[0])
                {
                    if(n<x.inside[1])
                    {
                        if (x.isRoot)
                        {
                            int temp = x.inside[0];
                            x.inside[0] = n;
                            x.L = new BTreeNodes(x);
                            insert(temp, *x.L);
                        }
                        else
                        {
                            int temp = x.inside[0];
                            x.inside[0] = n;
                            insert(temp, *x.F);
                        }
                    }
                }
                if(n>x.inside[0])
                {
                    if(n>x.inside[1])
                    {
                        insert(n,*x.R);
                    }
                }
            }

        }
    };

};
