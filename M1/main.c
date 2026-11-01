/* Yusuf Mert Turan, 5001240003, G4 */
#define N 27

const int SID = 706272707;
int arr[N];
int median, minV, maxV, swaps;

int should_swap(int a, int b){
    if(a < b){
        return 1;
    }
    return 0;
}

int main(){
    unsigned int x = SID;
    for(int i = 0; i < N; i++){
        x = 1664525 * x + 1013904223;
        arr[i] = (x >> 16) % 1000;
    }
    
    for(int i = 0; i < N - 1; i++){
        for(int j = 0; j < N - 1 - i; j++){
            if(should_swap(arr[j], arr[j + 1])){
                int t = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = t;
                swaps++;
            }
        }
    }

    median = arr[(N - 1) / 2] & 0x3FF;
    maxV = arr[0];
    minV = arr[N - 1];

    return 0;
}
